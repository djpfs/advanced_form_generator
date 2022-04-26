library advanced_form_generator;

import 'package:advanced_form_generator/utils/defaultInputDecoration.dart';
import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:advanced_form_generator/widgets/IFormFieldItem.dart';
import 'package:flutter/material.dart';

class AdvancedFormGenerator {
  /// List with all widgets
  final List<dynamic> _fields = [];

  /// map of field names to [TextEditingController]
  final Map<String, dynamic> _form = {};

  /// prefix for the map key of [FormFieldItem] and [IFormFieldItem]
  final String _fieldPrefix = 'field-';

  /// prefix for the map key of custom widgets
  final String _customPrefix = 'custom-';

  /// This [margin] is used for all fields, if you want to change it for some field, you can pass it to the constructor of [FormFieldItem]
  final EdgeInsets? margin;

  /// This [decoration] is used for all fields, if you want to change it for some field, you can pass it to the constructor of [FormFieldItem]
  final InputDecoration? decoration;

  /// Number of custom widgets in the form, used to generate unique keys to custom widgets
  int _qtdItems = 0;

  /// Create a new AdvancedFormGenerator instance
  ///
  /// [inputs] is a dynamic list, that can contain any type of object but the only fields that have the
  ///
  /// [TextEditingController] created are the [FormFieldItem]s and [IFormFieldItem]s.
  ///
  /// you can create your own [IFormFieldItem]s and add them to the [inputs] list.
  ///
  /// you can change the [margin] by passing a [EdgeInsets], default is
  /// ```dart
  /// EdgeInsets.symmetric(vertical: 8)
  /// ```
  ///
  /// you can change the [decoration] by passing a [InputDecoration], its default value is [defaultInputDecoration]
  ///
  /// you can change the [decoration] for single field by passing a [InputDecoration] to the FormFieldItem
  AdvancedFormGenerator(
      {required List<dynamic> inputs, this.decoration, this.margin}) {
    for (dynamic field in inputs) {
      _addField(field);
    }
  }

  /// Returns all widgets that were passed in the AdvancedFormGenerator initialization
  get getFields => _fields;

  /// Add a widget to [_fields], used internally
  ///
  /// if [field] is a [FormFieldItem] or [IFormFieldItem], a TextEditingController will be dynamically created for it
  /// else it will be added to [_fields]
  _addField(dynamic field) {
    if (field is FormFieldItem || field is IFormFieldItem) {
      _form[_fieldPrefix + field.mapKey] =
          TextEditingController(text: field.initialValue);
      field.controller = _form[_fieldPrefix + field.mapKey];
      field.decoration = field.decoration ??
          defaultInputDecotation(hintText: field.hint, labeltext: field.label);
    } else {
      /// Increment the number of custom widgets
      _qtdItems++;
      _form[_customPrefix + _qtdItems.toString()] = field;
    }

    /// Add the field to the list
    /// check if margin is null, if yes, use the default value
    /// if not use the value passed in the constructor
    _fields.add(margin == null
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 8), child: field)
        : Container(margin: margin, child: field));
  }

  /// Return a value from the input field with the [key]
  String? getValue(String key) {
    return _form['$_fieldPrefix$key']?.text;
  }

  /// Returns a [Map] with all the fields and their values
  ///
  /// [ignoreEmpty] - if true, will ignore empty fields - default: false
  ///
  /// [emptyValue] - value to be used if [ignoreEmpty] is false and the field is empty - default: false
  ///
  /// [ignoreEmpty] and [emptyValue] if active together, only [ignoreEmpty] will be considered
  Map<String, dynamic> toMap(
      {bool ignoreEmpty = false, bool emptyToNull = false}) {
    Map<String, dynamic> json = {};
    for (var key in _form.keys) {
      /// if is a custom widget, jump to the next one
      if (key.startsWith(_customPrefix)) continue;

      /// if is a field, check if the field is empty and the [ignoreEmpty[] flag is true
      if (ignoreEmpty && _form[key]!.text.isEmpty) continue;

      /// if is a field, check if the field is empty and the [emptyToNull] flag is true
      if (emptyToNull && _form[key]!.text.isEmpty) {
        /// set a value to null
        json[key.replaceFirst(_fieldPrefix, '')] = null;
      } else {
        /// get the value from [TextEditingController]
        json[key.replaceFirst(_fieldPrefix, '')] = _form[key]!.value.text;
      }
    }
    return json;
  }

  /// Resets all the [TextEditingController]s inside [FormFieldItem]s and [IFormFieldItem]s to empty
  void reset() {
    /// For each key in the map
    for (var key in _form.keys) {
      /// if is a custom widget, jump to the next one
      if (key.startsWith(_customPrefix)) continue;

      /// reset the [TextEditingController]
      _form[key]!.clear();
    }
  }

  /// Returns a [List] with all the widgets to render
  List<Widget> render() {
    List<Widget> widgets = [];

    /// For each field in _fields
    for (dynamic field in _fields) {
      if (field is FormFieldItem) {
        widgets.add(field);
      } else {
        widgets.add(field);
      }
    }
    return widgets;
  }
}
