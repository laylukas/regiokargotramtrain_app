import 'package:flutter/material.dart';

/// App header/AppBar widget displayed at the top of screens.
///
/// This header provides consistent navigation and branding across the app.
/// It includes a home button to navigate back to the start page and displays
/// the app logo and title.
class Header extends StatelessWidget implements PreferredSizeWidget {
  /// Title of the current page
  final String title;

  /// Current page index for determining visibility of navigation elements
  final int currentIndex;

  /// Whether to show a back button
  final bool showBackButton;

  const Header({
    super.key,
    required this.title,
    required this.currentIndex,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      // Show home button when not on the loading page (currentIndex != -1)
      leading: currentIndex != -1
          ? IconButton(
              iconSize: 40,
              icon: const Icon(Icons.home),
              tooltip: 'Zur Startseite',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/start');
              },
            )
          : null,
      // Display title or default text
      title: Text(
        currentIndex == -1 ? 'Lieferroboter' : title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      foregroundColor: Colors.black,
      // App logo on the right side
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/start'),
              child: Image.asset('assets/img/logo_tramtrain.png'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
