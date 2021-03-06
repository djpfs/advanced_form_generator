import 'package:flutter/material.dart';

class FormFieldSection extends StatelessWidget {
  final String title;
  final double height;
  const FormFieldSection({Key? key, required this.title, this.height = 45.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      child: Text(title.toUpperCase(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
    );
  }
}
