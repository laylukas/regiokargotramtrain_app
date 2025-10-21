import 'dart:async';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:regiokargotramtrain_app/config/mqtt_config.dart';

class MqttService {
  MqttService._();
  static final MqttService instance = MqttService._();

  MqttServerClient? _client;
  Completer<void>? _connecting;

  Future<void> _ensureConnected() async {
    // If already connected
    if (_client != null &&
        _client!.connectionStatus?.state == MqttConnectionState.connected) {
      return;
    }
    // If a connection is in-flight, await it
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
    client.keepAlivePeriod = 20;
    client.autoReconnect = true;
    client.onDisconnected = () {
      // noop for now; could add logging
    };

    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;

    try {
      if (MqttConfig.useTls) {
        client.secure = true;
        // Note: Not setting a custom SecurityContext to keep this cross-platform.
        // Provide certificates via client.securityContext if needed in future.
      }

      if (MqttConfig.username != null && MqttConfig.password != null) {
        await client.connect(MqttConfig.username, MqttConfig.password);
      } else {
        await client.connect();
      }

      if (client.connectionStatus?.state != MqttConnectionState.connected) {
        throw Exception('MQTT not connected: ${client.connectionStatus}');
      }

      _client = client;
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

  Future<void> publishStartScan({String? payload}) async {
    await _ensureConnected();

    final builder = MqttClientPayloadBuilder();
    builder.addString(
      payload ?? 'start',
    ); // kommt hier noch darauf an, was der MQTT-Server erwartet um die Kamera zu starten und den Scanvorgang zu beginnen.

    _client!.publishMessage(
      MqttConfig.topicStartScan,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: false,
    );
  }

  Future<void> disconnect() async {
    _client?.disconnect();
    _client = null;
  }
}
