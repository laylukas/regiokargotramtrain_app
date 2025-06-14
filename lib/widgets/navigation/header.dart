import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int currentIndex;
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
      leading:
          currentIndex != -1
              ? IconButton(
                iconSize: 40,
                icon: const Icon(Icons.home),
                tooltip: 'Zur Startseite',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/start');
                },
              )
              : null,
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
