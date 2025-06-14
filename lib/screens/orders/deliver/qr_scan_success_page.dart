import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/standard_button.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class QrScanSuccessPage extends StatelessWidget {
  final String trackingNumber;

  const QrScanSuccessPage({super.key, this.trackingNumber = "1234567890"});

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
                    Text(
                      'Bitte entnehmen Sie Ihre\n Sendung aus dem\n aufleuchtenden Fach.',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),
                    Image.asset(
                      'assets/gif/package_success.gif',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 64),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_shipping,
                            size: 50,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 32),
                          Text(
                            'Sendungsnummer: \n $trackingNumber',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    StandardButton(
                      label: 'Weiter',
                      onPressed: () {
                        // Weiter-Logik, z.B. Navigator.pushNamed(context, '/next_page');
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
