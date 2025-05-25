import 'package:flutter/material.dart';
import 'package:regiokargotramtrain_app/widgets/header.dart';
import 'package:regiokargotramtrain_app/widgets/navbar.dart';

class AccountPage extends StatelessWidget{
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        currentIndex: 3,
        title: 'Account Page',
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}