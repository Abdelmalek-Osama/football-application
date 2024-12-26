import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    required this.isBold,
    required this.colours,
    required this.fontSize,
  });
  String text;
  bool isBold;
  Color colours;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : null,
          fontSize: fontSize,
          color: colours),
      textAlign: TextAlign.center,
    );
  }
}
