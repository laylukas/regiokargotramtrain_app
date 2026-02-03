import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/wide_button.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: 2, title: 'Informationen'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WideButton(
                icon: Icons.info,
                label: 'Harry XXXXXXXXX',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ),
              const SizedBox(height: 32),
              WideButton(
                icon: Icons.radio_button_checked,
                label: '9 Freie Fächer',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
              const SizedBox(height: 32),
              WideButton(
                icon: Icons.radio_button_checked,
                label: '7 Freie Fächer',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 2),
    );
  }
}
 