import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        currentIndex: 0,
        title: 'More Page',
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}