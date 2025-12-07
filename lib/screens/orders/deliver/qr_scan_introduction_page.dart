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
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 200),
                    ),
                    const SizedBox(height: 32),
                    StandardButton(
                      label: 'Scanvorgang starten',
                      onPressed: () {
                        // debug: button pressed
                        // ignore: avoid_print
                        print('Start Scan button pressed');

                        // Fire-and-forget the publish so the UI can navigate immediately.
                        MqttService.instance
                            .publishStartScan()
                            .catchError((error, stackTrace) {
                              // Log detailed error for debugging
                              // ignore: avoid_print
                              print('MQTT publishStartScan error: ${error.toString()}');
                              // ignore: avoid_print
                              print(stackTrace);

                              final message = error?.toString() ?? 'Unbekannter Fehler';
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Fehler beim Starten des Scanvorgangs: $message')),
                                );
                              }
                            });

                        if (!context.mounted) return;

                        try {
                          // debug: before navigation
                          // ignore: avoid_print
                          print('Navigating to /qr_code_display');
                          Navigator.of(context).pushNamed('/qr_code_display');
                        } catch (e, st) {
                          // ignore: avoid_print
                          print('Navigation error: ${e.toString()}');
                          // ignore: avoid_print
                          print(st);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Navigation fehlgeschlagen: ${e.toString()}')),
                            );
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