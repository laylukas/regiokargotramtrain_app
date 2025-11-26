import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class QrScanFailed extends StatelessWidget {
	const QrScanFailed({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: const Header(title: 'Abholung', currentIndex: 0),
			body: Padding(
				padding: const EdgeInsets.all(24.0),
				child: Column(
					children: [
						const SizedBox(height: 32),
						Center(
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: [
									Icon(Icons.error, size: 96, color: Colors.red[700]),
									const SizedBox(height: 24),
									Text(
										'Scan fehlgeschlagen',
										style: Theme.of(context).textTheme.headlineSmall,
										textAlign: TextAlign.center,
									),
									const SizedBox(height: 16),
									Text(
										'Bitte versuchen Sie es erneut oder wenden Sie sich an den Support.',
										style: Theme.of(context).textTheme.bodyLarge,
										textAlign: TextAlign.center,
									),
									const SizedBox(height: 32),
									ElevatedButton(
										onPressed: () => Navigator.pop(context),
										child: const Text('Zurück'),
									)
								],
							),
						)
					],
				),
			),
			bottomNavigationBar: const Navbar(currentIndex: 0),
		);
	}
}
