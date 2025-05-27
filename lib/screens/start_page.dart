import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: -1, title: 'Start Page'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Was wollen Sie tun?',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareButton(icon: Icons.inbox, label: 'Abholen', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // add routes
                  SquareButton(icon: Icons.send, label: 'Versand', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // add routes
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}
