import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/wide_button.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: 2, title: 'Info Page'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WideButton(
                icon: Icons.send_outlined,
                label: 'Meine Sendungen',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
              WideButton(
                icon: Icons.qr_code,
                label: 'Online-Frankierung',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
              WideButton(
                icon: Icons.settings,
                label: 'Einstellungen',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
              WideButton(
                icon: Icons.person,
                label: 'Meine Daten',
                onPressed: () {},
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                textColor: Colors.black,
              ), // add route
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}
