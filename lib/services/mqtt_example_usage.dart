import 'dart:async';
import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/services/mqtt_service.dart';
import 'package:regiokargotramtrain_app/config/mqtt_config.dart';

/// Simple example widget showing how to use the MQTT service.
/// Replace the placeholders in `MqttConfig` first, then integrate this.
class MqttDemoWidget extends StatefulWidget {
  const MqttDemoWidget({super.key});

  @override
  State<MqttDemoWidget> createState() => _MqttDemoWidgetState();
}

class _MqttDemoWidgetState extends State<MqttDemoWidget> {
  final List<String> _log = [];
  late final StreamSubscription _sub;
  bool _connecting = false;

  @override
  void initState() {
    super.initState();
    _sub = MqttService.instance.messages.listen((msg) {
      setState(() {
        _log.add('[${msg.topic}] ${msg.payload}');
      });
    });
    _connect();
  }

  Future<void> _connect() async {
    if (_connecting) return;
    setState(() => _connecting = true);
    try {
      await MqttService.instance.connect();
      // Subscribe to status topic if available
      if (MqttConfig.topicStatus != null) {
        MqttService.instance.subscribe(MqttConfig.topicStatus!);
      }
    } catch (e) {
      setState(() => _log.add('ERROR: $e'));
    } finally {
      setState(() => _connecting = false);
    }
  }

  Future<void> _startScan() async {
    try {
      await MqttService.instance.publishStartScan();
    } catch (e) {
      setState(() => _log.add('Publish ERROR: $e'));
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    MqttService.instance.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connected = MqttService.instance.isConnected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: connected ? null : _connect,
              child: Text(connected ? 'Verbunden' : (_connecting ? 'Verbinde…' : 'Verbinden')),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: connected ? _startScan : null,
              child: const Text('Scan starten'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: _log.length,
              itemBuilder: (c, i) => Text(_log[i]),
            ),
          ),
        ),
      ],
    );
  }
}
