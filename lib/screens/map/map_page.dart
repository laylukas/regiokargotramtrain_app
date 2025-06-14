import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/header.dart';
import 'package:regiokargotramtrain_app/widgets/navigation/navbar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(currentIndex: 1, title: 'Standort'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/google_map_karlsruhe.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 1),
    );
  }
}
