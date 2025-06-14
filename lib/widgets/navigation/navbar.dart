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
    return SizedBox(
      height: 80,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Color(0xFF009940),
          unselectedItemColor: Colors.white,
          iconSize: 50,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex, // Muss 0, 1, 2 oder 3 sein!
          onTap: (index) => _onItemTapped(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}