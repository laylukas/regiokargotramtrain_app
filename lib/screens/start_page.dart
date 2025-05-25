import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        currentIndex: -1,
        title: 'Start Page',
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}