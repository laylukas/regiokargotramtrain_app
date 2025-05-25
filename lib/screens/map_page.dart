import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

class MapPage extends StatelessWidget{
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        currentIndex: 1,
        title: 'Map Page',
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}