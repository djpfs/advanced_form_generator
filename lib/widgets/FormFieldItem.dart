import 'package:advanced_form_generator/widgets/CustomLabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldItem extends StatelessWidget {
  late TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;
  final Function()? onTap;
  final Function(String val)? onChanged;
  final bool required;
  final bool isDisabled;
  final String? error;
  final String label;
  final String? counterText;
  final int? maxLength;
  final String? Function(String?, bool)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Icon? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? initialValue;
  final String mapKey;

  FormFieldItem(
      {Key? key,
      required this.label,
      required this.mapKey,
      this.textInputAction,
      this.controller,
      this.padding = const EdgeInsets.symmetric(horizontal: 16),
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.textInputType = TextInputType.text,
      this.hintText = '',
      this.counterText = '',
      this.required = false,
      this.isDisabled = false,
      this.obscureText = false,
      this.maxLength,
      this.validator,
      this.error = '',
      this.icon,
      this.initialValue,
      this.inputFormatters,
      this.onTap,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        onTap: onTap ?? () {},
        maxLength: maxLength,
        onChanged: onChanged,
        enabled: isDisabled ? false : true,
        validator: validator != null
            ? (val) => validator!(val, required)
            : defaultValidator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            label: CustomLabel(text: label),
            border: InputBorder.none,
            prefixIcon: icon,
            counterText: "",
            fillColor: Colors.transparent),
      ),
    );
  }

  String? defaultValidator(String? value) {
    if (required == true && (value == null || value.isEmpty)) {
      return error ?? 'Campo obrigatório';
    }
    return null;
  }
}
