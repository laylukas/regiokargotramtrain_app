import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          // pick up package
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.send, size: 40),
                            SizedBox(height: 8),
                            Text('Abholen', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                    SizedBox(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            // send package
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.inbox, size: 40),
                              SizedBox(height: 8),
                              Text('Versand', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
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
