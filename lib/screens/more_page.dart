import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';
import 'package:regiokargotramtrain_app/widgets/buttons/square_button.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: 0, title: 'Mehr'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Worüber wollen Sie mehr erfahren?',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareButton(
                        icon: Icons.info,
                        label: 'Allgemein',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      const SizedBox(width: 32),
                      SquareButton(
                        icon: Icons.question_answer,
                        label: 'FAQ',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareButton(
                        icon: Icons.settings,
                        label: 'Einstellung',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      const SizedBox(width: 32),
                      SquareButton(
                        icon: Icons.info_outline,
                        label: 'Über uns',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
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
