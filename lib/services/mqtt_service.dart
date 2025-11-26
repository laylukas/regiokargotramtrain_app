import 'dart:async';
import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
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

  MqttServerClient? _client;
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
    final client = MqttServerClient.withPort(
      MqttConfig.broker,
      clientId,
      MqttConfig.port,
    );
    client.logging(on: false);
    client.keepAlivePeriod = MqttConfig.keepAliveSeconds;
    client.autoReconnect = true;
    client.onDisconnected = _handleDisconnected;
    client.onConnected = _handleConnected;
    client.onAutoReconnect = _handleAutoReconnect;
    client.onAutoReconnected = _handleAutoReconnected;

    if (MqttConfig.useWebSocket) {
      client.useWebSocket = true;
      // NOTE: mqtt_client 10.x does not expose a websocket path setter.
      // If a path is required, include it in the broker string (e.g. 'host/path')
      // or update to a version that supports explicit path if available.
      // client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    }

    // Build connect message
    var conn = MqttConnectMessage().withClientIdentifier(clientId);
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
      if (MqttConfig.useTls) {
        client.secure = true;
        // If you need custom certificates later, attach a SecurityContext here.
      }

      if (MqttConfig.username != null && MqttConfig.password != null) {
        await client.connect(MqttConfig.username, MqttConfig.password);
      } else {
        await client.connect();
      }

      if (!isConnected) {
        throw Exception('MQTT not connected: ${client.connectionStatus}');
      }

      _client = client;
      // Listen to raw updates
      _client!.updates?.listen(_processUpdates);

      // Auto-subscribe to predefined topics if configured
      for (final t in [MqttConfig.topicAck, MqttConfig.topicStatus, MqttConfig.topicResult]) {
        if (t != null) {
          subscribe(t);
        }
      }

      _connecting!.complete();
    } catch (e) {
      _client?.disconnect();
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
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    _client!.publishMessage(topic, _toQos(qos), builder.payload!, retain: retain);
  }

  /// Convenience: publish a JSON-serializable object.
  Future<void> publishJson(
    String topic,
    Map<String, dynamic> jsonMap, {
    int qos = MqttConfig.defaultQos,
    bool retain = MqttConfig.defaultRetain,
  }) => publishString(topic, jsonEncode(jsonMap), qos: qos, retain: retain);

  /// Specific convenience method retained for compatibility with earlier code.
  Future<void> publishStartScan({String? payload}) => publishString(
        MqttConfig.topicStartScan,
        payload ?? 'start',
      );

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
