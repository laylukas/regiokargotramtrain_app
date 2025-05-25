import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

class InfoPage extends StatelessWidget{
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        currentIndex: 2,
        title: 'Info Page',
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}