import 'package:flutter/material.dart';

import '../widgets/FormFieldLabel.dart';

/// This is a default implementation of [InputDecoration] that can be used as a base for custom [InputDecoration]
///
/// It is used in [FormFieldItem] widget
///
/// You can change some properties of the [InputDecoration] by passing a lot of [InputDecoration] properties to the constructor,
/// or you can create your own [InputDecoration] and pass it to the [FormFieldItem] constructor to single field, or to the [AdvancedFormGenerator] constructor to all fields.
InputDecoration defaultInputDecotation(
    {String? hintText,
    Text? label,
    String? labeltext,
    String? prefixText,
    String? suffixText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String counterText = '',
    Color? fillColor,
    bool enabled = true,
    TextStyle? hintStyle,
    TextStyle? floatingLabelStyle,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    Icon? icon}) {
  return InputDecoration(
    hintText: hintText,
    errorText: errorText,
    prefixText: prefixText,
    suffixText: suffixText,
    counterText: counterText,
    label: label ?? FormFieldLabel(text: labeltext ?? ''),
    icon: icon,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    fillColor: fillColor ?? const Color(0xFFF2F3F5),
    enabled: enabled,
    floatingLabelAlignment: floatingLabelAlignment,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelStyle: floatingLabelStyle ??
        const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
    hintStyle: hintStyle ??
        const TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
        ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
  );
}
