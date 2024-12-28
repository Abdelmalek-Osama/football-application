import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}