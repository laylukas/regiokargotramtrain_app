/// Central MQTT configuration.
///
/// Fill in the placeholders below with your broker details. No other code
/// changes are required to connect, publish and subscribe via `MqttService`.
class MqttConfig {
  // === Connection ===
  /// Broker hostname or IP (e.g., 'broker.hivemq.com' or '192.168.1.10')
  // Broker to use for the app.
  // For local testing with the embedded test broker running on this
  // development machine, set this to the host's IPv4 address shown by
  // `ipconfig` (e.g. 172.28.160.1). For deployment when the broker runs
  // on the Raspberry Pi, change this to the Pi's IP 192.168.188.138.
  static const String broker = '192.168.188.138';

  /// Port number (1883 plain TCP, 8883 TLS, or WS-port for WebSocket)
  // Test server in `projector-animations/MQTT_Test_Server` exposes WebSocket on 9001
  // Use the standard MQTT TCP port for non-web Flutter clients so they
  // connect with the correct transport. The test broker also exposes
  // a WebSocket listener on 9001 (for browser clients), but mobile/desktop
  // apps should use 1883.
  static const int port = 1883;

  /// Set true if the broker requires TLS on the chosen port
  static const bool useTls = false;

  /// If your broker exposes MQTT over WebSocket (often required in browsers)
  // Use WebSocket in browser builds. Set to true for Flutter Web (Chrome).
  // Use WebSocket only for web builds. The `MqttService` implementation
  // already selects the websocket client on web via `kIsWeb` — keep this
  // false by default to avoid accidental websocket port usage on native.
  static const bool useWebSocket = false;

  /// Optional WebSocket path (commonly '/mqtt'). Ignored when useWebSocket=false
  /// Note: the embedded test broker does not expose a path, so use empty string.
  static const String websocketPath = '';

  /// WebSocket port (used by browser clients). The test broker exposes WS on 9001
  /// while TCP is on 1883. Keep these separate so native clients use plain TCP
  /// and web builds use the websocket listener.
  static const int websocketPort = 9001;

  /// Prefix for the client id. A unique suffix is added automatically.
  static const String clientIdPrefix = 'regiokargotramtrain_app_';

  /// KeepAlive in seconds
  static const int keepAliveSeconds = 20;

  /// Start with a clean session (no persisted subscriptions/queues)
  static const bool cleanSession = true;

  // === Authentication (test broker) ===
  // The embedded test broker (`MQTT_Test_Server/Server.py`) writes one test
  // user by default: user `test_user` with password `test_password`.
  // Set these here so browser and Pi clients authenticate correctly.
  static const String? username = 'test_user';
  static const String? password = 'test_password';

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
