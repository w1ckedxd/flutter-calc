import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.backgroundColor = const Color(0xFFC1C1C1),
    this.overlayColor = const Color(0xFF9C9C9C),
    required this.onButtonPressed,
    this.borderRadius = 10.0,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;
  final double borderRadius;
  final Widget child;
  final Color backgroundColor;
  final Color overlayColor;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(overlayColor),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      onTap: onButtonPressed,
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
