import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:regiokargotramtrain_app/config/mqtt_config.dart';

/// High level MQTT service wrapper.
///
/// Usage (after filling in `MqttConfig`):
///   await MqttService.instance.connect();
///   MqttService.instance.subscribe(MqttConfig.topicStatus!);
///   MqttService.instance.publishString(MqttConfig.topicStartScan, 'start');
///   MqttService.instance.messages.listen((m) => print(m));
class MqttService {
  MqttService._();
  static final MqttService instance = MqttService._();

  MqttClient? _client;
  // Single-flight connector for both platforms
  Completer<void>? _connecting;

  final StreamController<MqttAppMessage> _messageController =
      StreamController<MqttAppMessage>.broadcast();

  /// Stream of simplified incoming messages (topic + string payload)
  Stream<MqttAppMessage> get messages => _messageController.stream;

  bool get isConnected =>
      _client?.connectionStatus?.state == MqttConnectionState.connected;

  /// Establish a connection if not already connected.
  Future<void> connect() => _ensureConnected();

  /// Internal connect routine with single-flight behavior.
  Future<void> _ensureConnected() async {
    if (isConnected) return;
    if (_connecting != null && !_connecting!.isCompleted) {
      return _connecting!.future;
    }
    _connecting = Completer<void>();

    final clientId =
        '${MqttConfig.clientIdPrefix}${DateTime.now().microsecondsSinceEpoch}';

    // Choose the appropriate client for the platform. On Web use the
    // MqttBrowserClient which expects a websocket URL (ws:// or wss://).
    late final MqttClient client;
    if (kIsWeb) {
      final scheme = MqttConfig.useTls ? 'wss' : 'ws';
      final path = MqttConfig.websocketPath ?? '';
      final wsPort = MqttConfig.websocketPort ?? MqttConfig.port;
      final uri = '$scheme://${MqttConfig.broker}:${wsPort}$path';
      client = MqttBrowserClient(uri, "");
      // Some mqtt_client versions keep a separate `port`/`server` field.
      // Ensure they match the URI so the browser WS uses the correct port.
      try {
        (client as dynamic).server = uri;
      } catch (_) {}
      try {
        (client as dynamic).port = wsPort;
      } catch (_) {}
      // Debug: print resolved internal fields
      try {
        // ignore: avoid_print
        print('MQTT DEBUG: client.server=' + ((client as dynamic).server ?? 'null'));
        // ignore: avoid_print
        print('MQTT DEBUG: client.port=' + ((client as dynamic).port?.toString() ?? 'null'));
      } catch (_) {}
    } else {
      client = MqttServerClient.withPort(
        MqttConfig.broker,
        clientId,
        MqttConfig.port,
      );
    }

    // Enable verbose logging for debugging. Turn this off in production.
    client.logging(on: true);
    client.keepAlivePeriod = MqttConfig.keepAliveSeconds;
    // autoReconnect is only available for the VM client; guard safely
    try {
      // Debug: print which client / uri we will connect with
      if (kIsWeb) {
        final scheme = MqttConfig.useTls ? 'wss' : 'ws';
        final path = MqttConfig.websocketPath ?? '';
        final wsPort = MqttConfig.websocketPort ?? MqttConfig.port;
        final uri = '$scheme://${MqttConfig.broker}:${wsPort}$path';
        // ignore: avoid_print
        print('MQTT DEBUG: Web client will connect to $uri with clientId=$clientId');
      } else {
        // ignore: avoid_print
        print('MQTT DEBUG: VM client will connect to ${MqttConfig.broker}:${MqttConfig.port} with clientId=$clientId');
      }
      // some implementations support autoReconnect
      (client as dynamic).autoReconnect = true;
    } catch (_) {}
    client.onDisconnected = _handleDisconnected;
    client.onConnected = _handleConnected;
    try {
      client.onAutoReconnect = _handleAutoReconnect;
      client.onAutoReconnected = _handleAutoReconnected;
    } catch (_) {}

    // Build connect message
    var conn = MqttConnectMessage().withClientIdentifier(clientId);
    // Try to prefer MQTT v3.1.1 (ProtocolName = 'MQTT', ProtocolVersion = 4)
    // Some versions of `mqtt_client` expose helper methods or fields to
    // change the protocol name/version. Attempt the common ones dynamically
    // so this code works across multiple versions; if a method/field does
    // not exist the call will be ignored.
    try {
      try {
        (conn as dynamic).withProtocolName('MQTT');
      } catch (_) {}
      try {
        (conn as dynamic).withProtocolVersion(4);
      } catch (_) {}
      try {
        (conn as dynamic).withProtocolLevel(4);
      } catch (_) {}
      try {
        (conn as dynamic).protocolVersion = 4;
      } catch (_) {}
    } catch (_) {}
    if (MqttConfig.cleanSession) {
      conn = conn.startClean();
    }
    if (MqttConfig.willTopic != null) {
      conn = conn.withWillTopic(MqttConfig.willTopic!)
          .withWillMessage(MqttConfig.willMessage)
          .withWillQos(_toQos(MqttConfig.willQos))
          .withWillRetain();
      if (!MqttConfig.willRetain) {
        // Library only exposes retain via withWillRetain(); if false just ignore.
      }
    }
    conn = conn.withWillQos(MqttQos.atLeastOnce); // ensure Will QoS is set
    client.connectionMessage = conn;

    try {
      if (!kIsWeb && MqttConfig.useTls && client is MqttServerClient) {
        // Only the server client (VM) implementation exposes `secure`.
        (client as MqttServerClient).secure = true;
        // If you need custom certificates later, attach a SecurityContext here.
      }

      if (MqttConfig.username != null && MqttConfig.password != null) {
        // ignore: avoid_print
        print('MQTT DEBUG: connecting with username ${MqttConfig.username}');
        await client.connect(MqttConfig.username, MqttConfig.password);
      } else {
        // ignore: avoid_print
        print('MQTT DEBUG: connecting without credentials');
        await client.connect();
      }

      // The local `client` was just used to connect. Don't rely on the
      // `isConnected` getter which checks `_client` (not yet assigned).
      // Instead inspect the freshly connected client's status.
      if (client.connectionStatus?.state != MqttConnectionState.connected) {
        print("DEBUG ERROR: $client");
        throw Exception('MQTT not connected: ${client.connectionStatus}');
      }

      _client = client;
      // Debug: report connection status
      // ignore: avoid_print
      print('MQTT DEBUG: connectionStatus=${_client?.connectionStatus}');
      // Listen to raw updates
      try {
        _client!.updates?.listen(_processUpdates);
      } catch (_) {}

      // Auto-subscribe to predefined topics if configured
      for (final t in [MqttConfig.topicAck, MqttConfig.topicStatus, MqttConfig.topicResult]) {
        if (t != null) {
          subscribe(t);
        }
      }

      _connecting!.complete();
    } catch (e) {
      try {
        _client?.disconnect();
      } catch (_) {}
      _client = null;
      if (!(_connecting?.isCompleted ?? true)) {
        _connecting!.completeError(e);
      }
      rethrow;
    } finally {
      _connecting = null;
    }
  }

  /// Subscribe to a topic with optional QoS.
  void subscribe(String topic, {int qos = MqttConfig.defaultQos}) {
    if (!isConnected) return; // Optionally throw
    _client!.subscribe(topic, _toQos(qos));
  }

  /// Unsubscribe from a topic.
  void unsubscribe(String topic) {
    if (!isConnected) return;
    _client!.unsubscribe(topic);
  }

  /// Publish a simple string payload.
  Future<void> publishString(
    String topic,
    String payload, {
    int qos = MqttConfig.defaultQos,
    bool retain = MqttConfig.defaultRetain,
  }) async {
    await _ensureConnected();
    // Debug: show publish intent
    // ignore: avoid_print
    print('MQTT DEBUG: publishing to $topic payload=${payload} qos=$qos retain=$retain');
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    try {
      _client!.publishMessage(topic, _toQos(qos), builder.payload!, retain: retain);
      // ignore: avoid_print
      print('MQTT DEBUG: publish called for $topic');
    } catch (e, st) {
      // ignore: avoid_print
      print('MQTT DEBUG: publish error: $e');
      // ignore: avoid_print
      print(st);
      rethrow;
    }
  }

  /// Convenience: publish a JSON-serializable object.
  Future<void> publishJson(
    String topic,
    Map<String, dynamic> jsonMap, {
    int qos = MqttConfig.defaultQos,
    bool retain = MqttConfig.defaultRetain,
  }) => publishString(topic, jsonEncode(jsonMap), qos: qos, retain: retain);

  /// Specific convenience method retained for compatibility with earlier code.
  /// Publish a structured start_scan command as JSON so devices expecting
  /// `{ "command": "start_scan" }` will parse it correctly.
  /// Publish a start-scan command.
  ///
  /// By default the payload uses the `command` key: `{ "command": "start_scan" }`.
  /// Set [useStatusKey] to true to use `{ "status": "start_scan" }` for
  /// compatibility with configs that expect `status` instead of `command`.
  Future<void> publishStartScan({String? payload, Map<String, dynamic>? extra, bool useStatusKey = false}) {
    final Map<String, dynamic> body = {useStatusKey ? 'status' : 'command': 'start_scan'};
    if (payload != null) body['payload'] = payload;
    if (extra != null) body.addAll(extra);
    return publishJson(MqttConfig.topicStartScan, body);
  }

  /// Disconnect gracefully.
  Future<void> disconnect() async {
    _client?.disconnect();
    _client = null;
  }

  // === Internal helpers ===
  void _processUpdates(List<MqttReceivedMessage<MqttMessage>>? messages) {
    if (messages == null) return;
    for (final m in messages) {
      final payload = m.payload;
      String? content;
      if (payload is MqttPublishMessage) {
        final bytes = payload.payload.message;
        content = MqttPublishPayload.bytesToStringAsString(bytes);
      }
      if (content != null) {
        _messageController.add(
          MqttAppMessage(topic: m.topic, payload: content),
        );
      }
    }
  }

  void _handleDisconnected() {
    // Could emit a status event; for now just log via stream
    _messageController.add(
      MqttAppMessage(topic: '__status__', payload: 'disconnected'),
    );
  }

  void _handleConnected() {
    _messageController.add(
      MqttAppMessage(topic: '__status__', payload: 'connected'),
    );
  }

  void _handleAutoReconnect() {
    _messageController.add(
      MqttAppMessage(topic: '__status__', payload: 'reconnecting'),
    );
  }

  void _handleAutoReconnected() {
    _messageController.add(
      MqttAppMessage(topic: '__status__', payload: 'reconnected'),
    );
  }

  MqttQos _toQos(int qos) {
    switch (qos) {
      case 0:
        return MqttQos.atMostOnce;
      case 1:
        return MqttQos.atLeastOnce;
      case 2:
        return MqttQos.exactlyOnce;
      default:
        return MqttQos.atLeastOnce;
    }
  }
}

/// Simple DTO for incoming app messages.
class MqttAppMessage {
  final String topic;
  final String payload;
  const MqttAppMessage({required this.topic, required this.payload});

  @override
  String toString() => 'MqttAppMessage(topic: $topic, payload: $payload)';
}
