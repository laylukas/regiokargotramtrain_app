import 'package:flutter/material.dart';

/// A rounded button widget combining icon and text label with hover/press effects.
///
/// This button displays an icon next to text and provides visual feedback
/// during user interactions (hover and press states).
class IconAndRoundedButton extends StatefulWidget {
  /// The text label displayed next to the icon
  final String label;

  /// The icon displayed next to the label
  final IconData icon;

  /// Callback function triggered when the button is pressed
  final VoidCallback onPressed;

  /// Background color of the button (default: white)
  final Color backgroundColor;

  /// Color of the text label (default: black)
  final Color textColor;

  /// Color of the icon (default: black)
  final Color iconColor;

  const IconAndRoundedButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });

  @override
  State<IconAndRoundedButton> createState() => _IconAndRoundedButtonState();
}

class _IconAndRoundedButtonState extends State<IconAndRoundedButton> {
  /// Track if the button is currently being pressed
  bool _isPressed = false;

  /// Track if the mouse is hovering over the button
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Change border color based on interaction state
    final borderColor = (_isPressed || _isHovered) ? Colors.green : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Listener(
        onPointerDown: (_) => setState(() => _isPressed = true),
        onPointerUp: (_) => setState(() => _isPressed = false),
        child: AnimatedContainer(
          // Smooth animation for state transitions
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(36),
            // Add shadow for depth
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            // Border appears on hover/press
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 46),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon on the left
                    Icon(widget.icon, color: widget.iconColor, size: 32),
                    const SizedBox(width: 32),
                    // Label text on the right
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}