import 'package:flutter/material.dart';

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
              Text(
                'Herzlich Willkommen bei RegioKArgoTramTrain',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Mit unserer App können Sie in wenigen Schritten Ihr Paket von'
                'einem Lieferroboter abholen oder versenden lassen!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Image.asset(
                'assets/img/logo_tramtrain.png',
                height: 120,
              ),
              const SizedBox(height: 24),
              const Text(
                'Klicken Sie auf "Weiter", um den Vorgang zu starten.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Beispiel: Navigation zur Startseite
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