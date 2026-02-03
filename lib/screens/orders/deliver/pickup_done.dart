import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/standard_button.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class PickupDone extends StatelessWidget {
  const PickupDone({super.key});

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
              'Vielen Dank für die Nutzung \n unserer App!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 42),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text(
              'Bestellung wurde erfolgreich entnommen.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Icon(Icons.emoji_emotions, size: 150, color: Colors.green),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StandardButton(
                  label: 'Fertig',
                  onPressed: () {
                    Navigator.pushNamed(context, '/start');
                  },
                  backgroundColor: Colors.white,
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
