import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  final bool isUpper;
  final double fontSize;
  final TextAlign textAlign;
  final Color? color;
  final FontWeight? fontWeight;

  const CustomLabel(
      {Key? key,
      required this.text,
      this.isUpper = true,
      this.textAlign = TextAlign.left,
      this.color,
      this.fontWeight,
      this.fontSize = 18.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpper ? text.toUpperCase() : text,
      textAlign: textAlign,
    );
  }
}
