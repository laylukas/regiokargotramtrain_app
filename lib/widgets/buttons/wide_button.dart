import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: Offset(0, 5),
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
              Icon(icon, size: 70, color: iconColor),
              const SizedBox(width: 32),
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
