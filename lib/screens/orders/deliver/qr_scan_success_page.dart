import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/standard_button.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class QrScanSuccessPage extends StatelessWidget {
  final String trackingNumber;

  const QrScanSuccessPage({super.key, this.trackingNumber = "1234567890"});

  void _showPickupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SizedBox(
          width: 600,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Haben Sie Ihre Sendung entnommen?',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareButton(
                      icon: Icons.check,
                      label: 'Ja',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/repetition_process');
                      },
                      backgroundColor: Colors.green[50]!,
                      iconColor: Colors.green,
                      textColor: Colors.green,
                    ),
                    const SizedBox(width: 32),
                    SquareButton(
                      icon: Icons.close,
                      label: 'Nein',
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                      backgroundColor: Colors.red[50]!,
                      iconColor: Colors.red,
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Abholung', currentIndex: 0),
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
                    Image.asset(
                      'assets/gif/package_success.gif',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Bitte entnehmen Sie Ihre Sendung aus Feld',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_shipping, size: 32, color: Colors.green),
                          const SizedBox(width: 16),
                          Text(
                            trackingNumber,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                      onPressed: () => _showPickupDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 0),
    );
  }
}