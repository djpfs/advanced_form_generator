import 'package:flutter/material.dart';

/// Interface for form field items
///
/// This interface is used to create custom form field items.
abstract class IFormFieldItem {
  TextEditingController? controller;
  InputDecoration? decoration;
  String? initialValue;
  String? hint;
  late String label;
  late String mapKey;
}
