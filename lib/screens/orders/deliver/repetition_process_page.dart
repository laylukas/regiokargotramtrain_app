import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class RepetitionProcessPage extends StatelessWidget {
  const RepetitionProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Abholung', currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wollen Sie eine weitere Sendung entnehmen?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Icon(Icons.local_shipping, size: 80, color: Colors.green),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareButton(
                  icon: Icons.check,
                  label: 'Ja',
                  onPressed: () {
                    Navigator.pushNamed(context, '/qr_scan_introduction');
                  },
                  backgroundColor: Colors.white,
                  iconColor: Colors.green,
                  textColor: Colors.black,
                ),
                const SizedBox(width: 32),
                SquareButton(
                  icon: Icons.close,
                  label: 'Nein',
                  onPressed: () {
                    Navigator.pushNamed(context, '/pickup_done');
                  },
                  backgroundColor: Colors.white,
                  iconColor: Colors.red,
                  textColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 0),
    );
  }
}
