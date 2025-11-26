import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';
import 'package:regiokargotramtrain_app/services/mqtt_service.dart';
import 'package:regiokargotramtrain_app/config/mqtt_config.dart';
import 'dart:convert';

class QrCodeDisplayPage extends StatefulWidget {
  final String qrData;

  const QrCodeDisplayPage({super.key, this.qrData = "Beispiel-QR-Daten"});

  @override
  State<QrCodeDisplayPage> createState() => _QrCodeDisplayPageState();
}

class _QrCodeDisplayPageState extends State<QrCodeDisplayPage> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    // Start MQTT setup. use async method so we can await connection
    _initMqtt();
  }

  Future<void> _initMqtt() async {
    try {
      // try connecting and wait for completion
      await MqttService.instance.connect();
      // debug
      // ignore: avoid_print
      print('MQTT: connected from UI, subscribing to result topic');

      // subscribe to incoming result messages
      _sub = MqttService.instance.messages.listen((msg) {
        // ignore debug/status messages
        if (msg.topic == (MqttConfig.topicResult ?? 'regiokargo/scanner/result')) {
          try {
            final data = jsonDecode(msg.payload) as Map<String, dynamic>;
            final status = data['status'];
            // ignore if widget disposed
            if (!mounted) return;
            if (status == 'ok') {
              Navigator.pushNamed(context, '/qr_scan_success');
            } else {
              Navigator.pushNamed(context, '/qr_scan_failed');
            }
          } catch (e) {
            // ignore parse errors but log
            // ignore: avoid_print
            print('MQTT: failed to parse result payload: ${e.toString()}');
          }
        }
      });

      // publish start scan command when page is opened
      final expected = _parseExpectedCompartment(widget.qrData);
      final payload = {
        'command': 'start_scan',
        if (expected != null) 'expected_compartment': expected,
      };

      // debug
      // ignore: avoid_print
      print('MQTT: publishing start_scan -> $payload to ${MqttConfig.topicStartScan}');
      await MqttService.instance.publishJson(MqttConfig.topicStartScan, payload);
      // debug
      // ignore: avoid_print
      print('MQTT: publish complete');
    } catch (e) {
      // ignore: avoid_print
      print('MQTT: connection/setup error: ${e.toString()}');
    }
  }

  int? _parseExpectedCompartment(String qrData) {
    try {
      final map = jsonDecode(qrData);
      if (map is Map && map.containsKey('compartment')) return map['compartment'] as int;
    } catch (e) {}
    final reg = RegExp(r"\d+");
    final m = reg.firstMatch(qrData);
    if (m != null) return int.tryParse(m.group(0)!);
    return null;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Abholung', currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Zurück',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QrImageView(
                      data: widget.qrData,
                      size: 250.0,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Bitte halten Sie diesen QR-Code an den Scanner.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Test-Buttons:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/qr_scan_success');
                          },
                          child: const Text('Scan erfolgreich'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/qr_scan_failed');
                          },
                          child: const Text('Scan fehlgeschlagen'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}