import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FormFieldItem extends StatelessWidget {
  late TextEditingController? controller;
  final TextInputAction? textInputAction;
  late InputDecoration? decoration;
  final TextInputType textInputType;
  final TextStyle? style;
  final bool obscureText;
  final bool readOnly;
  final bool autocorrect;
  final bool autofocus;
  final Function()? onTap;
  final Function(String val)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final bool required;
  final bool enabled;
  final String label;
  final String? hint;
  final int? maxLength;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String mapKey;
  final String? initialValue;

  /// Create a new FormFieldItem instance
  ///
  /// required [mapKey] is the key that will be used to save the value in the [Map] returned by [toMap] method in AdvancedFormGenerator instance
  /// required [label] is the label of the field
  FormFieldItem({
    Key? key,
    required this.label,
    required this.mapKey,
    this.hint,
    this.textInputAction,
    this.controller,
    this.decoration,
    this.style,
    this.textInputType = TextInputType.text,
    this.required = false,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.readOnly = false,
    this.initialValue,
    this.maxLength,
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: style ?? TextStyle(fontSize: 16, color: Colors.grey[900]),
      onTap: onTap ?? () {},
      maxLength: maxLength,
      onChanged: onChanged,
      enabled: enabled,
      validator: validator,
      autofocus: autofocus,
      autocorrect: autocorrect,
      initialValue: initialValue,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: decoration,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
