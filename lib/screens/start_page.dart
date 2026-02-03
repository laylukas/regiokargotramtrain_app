import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';

/// Main start page where users choose between picking up or shipping packages.
///
/// This page provides the primary navigation for the two main operations:
/// - Package pickup
/// - Package shipping
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
              // Main heading asking user what they want to do
              Text(
                'Was wollen Sie tun?',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Action buttons for pickup and shipping
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pickup button
                  SquareButton(
                    icon: Icons.inbox,
                    label: 'Abholen',
                    onPressed: () {
                      Navigator.pushNamed(context, '/qr_scan_introduction');
                    },
                    backgroundColor: Colors.white,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  const SizedBox(width: 32),
                  // Shipping button (placeholder for future implementation)
                  SquareButton(
                    icon: Icons.send,
                    label: 'Versand',
                    onPressed: () {
                      // TODO: Implement shipping functionality
                    },
                    backgroundColor: Colors.white,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}
