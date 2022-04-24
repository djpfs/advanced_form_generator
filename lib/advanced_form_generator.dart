library advanced_form_generator;

import 'package:advanced_form_generator/utils/DefaultInputDecoration.dart';
import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:flutter/material.dart';

import 'widgets/IFormFieldItem.dart';

class AdvancedFormGenerator {
  final List<dynamic> _fields = [];
  final Map<String, dynamic> _form = {};
  final String _fieldPrefix = 'field-';
  final String _customPrefix = 'custom-';
  final EdgeInsets? margin;
  final InputDecoration? decoration;

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
  /// EdgeInsets.symmetric(vertical: 12)
  /// ```
  ///
  /// you can change the [decoration] by passing a [InputDecoration], its default value is [DefaultInputDecoration]
  ///
  /// you can change the [decoration] for single field by passing a [InputDecoration] to the FormFieldItem
  AdvancedFormGenerator(
      {required List<dynamic> inputs, this.decoration, this.margin}) {
    for (dynamic field in inputs) {
      _addField(field);
    }
  }

  get getFields => _fields;

  _addField(dynamic field) {
    if (field is FormFieldItem || field is IFormFieldItem) {
      _form[_fieldPrefix + field.mapKey] =
          TextEditingController(text: field.initialValue);
      field.controller = _form[_fieldPrefix + field.mapKey];
      field.decoration = field.decoration ??
          defaultInputDecotation(hintText: field.hint, labeltext: field.label);
    } else {
      _form[_customPrefix + _qtdItems.toString()] = field;
    }
    _qtdItems++;
    _fields.add(margin == null
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 12), child: field)
        : field);
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
      if (key.startsWith(_customPrefix)) continue;
      if (ignoreEmpty && _form[key]!.text.isEmpty) continue;
      if (emptyToNull && _form[key]!.text.isEmpty) {
        json[key.replaceFirst(_fieldPrefix, '')] = null;
      } else {
        json[key.replaceFirst(_fieldPrefix, '')] = _form[key]!.value.text;
      }
    }
    return json;
  }

  /// Resets all the [TextEditingController]s inside [FormFieldItem]s and [IFormFieldItem]s to empty
  void reset() {
    for (var key in _form.keys) {
      if (key.startsWith(_customPrefix)) continue;
      _form[key]!.clear();
    }
  }

  /// Returns a [List] with all the widgets to render
  List<Widget> render() {
    List<Widget> widgets = [];
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
