import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: 0, title: 'More Page'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Worüber wollen Sie mehr erfahren?',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    SquareButton(icon: Icons.info, label: 'Allgemein', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // TODO: open general page 
                    SquareButton(icon: Icons.question_answer, label: 'FAQ', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // TODO: open faq page
                    SquareButton(icon: Icons.settings, label: 'Einstellung', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // TODO: open settings page
                    SquareButton(icon: Icons.info_outline, label: 'Über uns', onPressed: () {}, backgroundColor: Colors.white, iconColor: Colors.black, textColor: Colors.black), // TODO: open about us page
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}
