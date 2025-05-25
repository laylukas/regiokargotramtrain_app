import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;

  const Navbar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    String targetRoute;
    switch (index) {
      case 0:
        targetRoute = '/more';
        break;
      case 1:
        targetRoute = '/map';
        break;
      case 2:
        targetRoute = '/info';
        break;
      case 3:
        targetRoute = '/account';
        break;
      default:
        return;
    }

    Navigator.pushReplacementNamed(context, targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:
          currentIndex < 0 ? 999 : currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Mehr'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Karte'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Konto'),
      ],
    );
  }
}
