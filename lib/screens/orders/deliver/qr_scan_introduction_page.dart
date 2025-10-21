import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/standard_button.dart';
import 'package:regiokargotramtrain_app/services/mqtt_service.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class QrScanInstructionPage extends StatelessWidget {
  const QrScanInstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Abholung', currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Zurück',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Bitte scannen Sie den QR-Code am Scanner ein. \n Das folgende GIF zeigt Ihnen, wie es funktioniert.',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/gif/qr_scan_example.gif', // muessen wir noch erstellen
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),
                    StandardButton(
                      label: 'Scanvorgang starten',
                      onPressed: () async {
                        try {
                          // Publish an MQTT message to trigger scanner start
                          await MqttService.instance.publishStartScan();
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Fehler beim Starten des Scanvorgangs: $e')),
                            );
                          }
                          // Still navigate for now to keep flow; remove if you want strict blocking
                        } finally {
                          if (context.mounted) {
                            Navigator.pushNamed(context, '/qr_code_display');
                          }
                        }
                      },
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