import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class QrCodeDisplayPage extends StatelessWidget {
  final String qrData;

  const QrCodeDisplayPage({super.key, this.qrData = "Beispiel-QR-Daten"});

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
                      data: qrData,
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