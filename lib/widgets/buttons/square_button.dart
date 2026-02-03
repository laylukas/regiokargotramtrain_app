import 'package:flutter/material.dart';

/// A customizable square button widget with icon and label.
///
/// This button is typically used for main action items on the start page
/// and other screens. It displays an icon above a label text.
class SquareButton extends StatelessWidget {
  /// The icon to display in the button
  final IconData icon;

  /// The text label displayed below the icon
  final String label;

  /// Callback function triggered when the button is pressed
  final VoidCallback onPressed;

  /// Background color of the button
  final Color backgroundColor;

  /// Color of the icon
  final Color iconColor;

  /// Color of the text label
  final Color textColor;

  const SquareButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Add shadow for depth
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.zero,
            elevation: 0, // Remove default shadow to use custom shadow
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon display
              Icon(icon, size: 70, color: iconColor),
              const SizedBox(height: 8),
              // Label text
              Text(
                label,
                style: TextStyle(fontSize: 22, color: textColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}