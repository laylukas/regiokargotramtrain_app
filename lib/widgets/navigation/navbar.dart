import 'package:flutter/material.dart';

/// Bottom navigation bar widget for the main application.
///
/// Provides navigation between the main application screens:
/// - More (index 0)
/// - Map (index 1)
/// - Information (index 2)
/// - Account (index 3)
class Navbar extends StatelessWidget {
  /// The current index of the selected navigation item
  final int currentIndex;

  const Navbar({super.key, required this.currentIndex});

  /// Handle navigation when a bottom navigation item is tapped.
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
        // Round the top-right corner for a modern look
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: const Color(0xFF009940),
          unselectedItemColor: Colors.white,
          iconSize: 50,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: '',
              tooltip: 'Erfahre mehr',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '',
              tooltip: 'Karte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: '',
              tooltip: 'Informationen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
              tooltip: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}