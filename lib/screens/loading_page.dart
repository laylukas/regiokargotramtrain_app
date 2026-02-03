import 'package:flutter/material.dart';

/// Initial loading/welcome page of the RegioKargo TramTrain application.
///
/// This page serves as the welcome screen that introduces users to the app
/// and provides the initial navigation to the main start page.
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome title
              Text(
                'Herzlich Willkommen bei RegioKArgoTramTrain',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description text
              const Text(
                'Mit unserer App können Sie in wenigen Schritten Ihr Paket von '
                'einem Lieferroboter abholen oder versenden lassen!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // App logo
              Image.asset(
                'assets/img/logo_tramtrain.png',
                height: 120,
              ),
              const SizedBox(height: 24),
              // Instructions for the user
              const Text(
                'Klicken Sie auf "Weiter", um den Vorgang zu starten.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Navigation button to start page
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/start');
                },
                child: const Text('Weiter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}