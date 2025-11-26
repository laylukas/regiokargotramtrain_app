/// Central MQTT configuration.
///
/// Fill in the placeholders below with your broker details. No other code
/// changes are required to connect, publish and subscribe via `MqttService`.
class MqttConfig {
  // === Connection ===
  /// Broker hostname or IP (e.g., 'broker.hivemq.com' or '192.168.1.10')
  // Default to local test broker. Change to your production broker when needed.
  static const String broker = 'localhost';

  /// Port number (1883 plain TCP, 8883 TLS, or WS-port for WebSocket)
  // Test server in `projector-animations/MQTT_Test_Server` binds to port 9001
  static const int port = 9001;

  /// Set true if the broker requires TLS on the chosen port
  static const bool useTls = false;

  /// If your broker exposes MQTT over WebSocket (often required in browsers)
  static const bool useWebSocket = false;

  /// Optional WebSocket path (commonly '/mqtt'). Ignored when useWebSocket=false
  static const String websocketPath = '/mqtt';

  /// Prefix for the client id. A unique suffix is added automatically.
  static const String clientIdPrefix = 'regiokargotramtrain_app_';

  /// KeepAlive in seconds
  static const int keepAliveSeconds = 20;

  /// Start with a clean session (no persisted subscriptions/queues)
  static const bool cleanSession = true;

  // === Authentication (optional) ===
  static const String? username = null; // e.g., 'student'
  static const String? password = null; // e.g., 'secret'

  // === Last Will & Testament (optional but recommended) ===
  /// Set to a topic if you want the broker to publish a will message on
  /// unexpected disconnects.
  static const String? willTopic = null; // e.g., 'apps/regiokargo/clients/+/status'
  static const String willMessage = 'offline';
  static const int willQos = 1; // 0,1,2
  static const bool willRetain = false;

  // === Default publish settings ===
  static const int defaultQos = 1; // 0,1,2
  static const bool defaultRetain = false;

  // === Topics used by the app ===
  /// Command topic to trigger scanning on the device/server
  static const String topicStartScan = 'regiokargo/scanner/command';

  /// Optional topics you might want to subscribe to for acknowledgements / status
  static const String? topicAck = 'regiokargo/scanner/ack';
  static const String? topicStatus = 'regiokargo/scanner/status';
  static const String? topicResult = 'regiokargo/scanner/result';

  // === TLS Certificates (advanced, optional) ===
  // If your broker uses a private CA or requires client certificates, you can
  // bundle the files and load them in MqttService (platforms supporting dart:io).
  // Example placeholders if needed in the future:
  // static const String? caCertAsset = 'assets/certs/ca.crt';
  // static const String? clientCertAsset = 'assets/certs/client.crt';
  // static const String? clientKeyAsset = 'assets/certs/client.key';
}
