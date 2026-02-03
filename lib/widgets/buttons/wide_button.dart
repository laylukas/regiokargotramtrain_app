import 'package:flutter/material.dart';

/// A wide rectangular button widget with icon and label.
///
/// This button displays an icon on the left and label text on the right.
/// It's typically used for detailed action items or menu options.
class WideButton extends StatelessWidget {
  /// The icon to display on the left side
  final IconData icon;

  /// The text label displayed to the right of the icon
  final String label;

  /// Callback function triggered when the button is pressed
  final VoidCallback onPressed;

  /// Background color of the button
  final Color backgroundColor;

  /// Color of the icon
  final Color iconColor;

  /// Color of the text label
  final Color textColor;

  const WideButton({
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
      width: 600,
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
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0, // Remove default shadow to use custom one
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 32),
              // Icon on the left
              Icon(icon, size: 70, color: iconColor),
              const SizedBox(width: 32),
              // Label text on the right
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 22, color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
