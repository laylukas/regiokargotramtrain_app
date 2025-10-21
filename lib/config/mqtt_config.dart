class MqttConfig {
  // TODO: Replace placeholders with actual values once available
  static const String broker = 'mqtt.hfu.example.org'; // e.g., 'broker.hivemq.com'
  static const int port = 1883; // 8883 for TLS
  static const String clientIdPrefix = 'regiokargotramtrain_app_';

  // Optional authentication
  static const String? username = null; // e.g., 'student'
  static const String? password = null; // e.g., 'secret'

  // Topics
  static const String topicStartScan = 'regiokargo/scan/start';

  // TLS (if required later)
  static const bool useTls = false; // set to true when broker requires TLS
}
