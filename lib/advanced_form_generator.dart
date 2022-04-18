library advanced_form_generator;

import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:advanced_form_generator/widgets/FormSection.dart';
import 'package:flutter/material.dart';

class AdvancedFormGenerator {
  final List<dynamic> _fields = [];
  final Map<String, dynamic> _form = {};
  int _qtdItems = 0;
  final String _fieldPrefix = 'field-';
  final String _sectionPrefix = 'section-';

  AdvancedFormGenerator(List<dynamic> fields) {
    addFields(fields);
  }

  get getFields => _fields;

  addField(dynamic field) {
    if (field is FormFieldItem) {
      _form[_fieldPrefix + field.mapKey] =
          TextEditingController(text: field.initialValue);
    } else if (field is FormSection) {
      _form[_sectionPrefix + _qtdItems.toString()] = field;
    } else {
      throw Exception('Invalid field type');
    }
    _qtdItems++;
    _fields.add(field);
  }

  addFields(List<dynamic> fields) {
    for (dynamic field in fields) {
      addField(field);
    }
  }

  toMap({bool ignoreEmpty = false, bool emptyToNull = false}) {
    Map<String, dynamic> json = {};
    for (var key in _form.keys) {
      if (key.startsWith(_sectionPrefix)) continue;
      if (ignoreEmpty && _form[key]!.text.isEmpty) continue;
      if (emptyToNull && _form[key]!.text.isEmpty) {
        json[key.replaceFirst(_fieldPrefix, '')] = null;
      } else {
        json[key.replaceFirst(_fieldPrefix, '')] = _form[key]!.value.text;
      }
    }
    return json;
  }

  // Reset all TextEditingController from Form
  resetForm() {
    for (var key in _form.keys) {
      if (key.startsWith(_sectionPrefix)) continue;
      _form[key]!.clear();
    }
  }

  List<Widget> render() {
    List<Widget> widgets = [];
    for (dynamic field in _fields) {
      if (field is FormFieldItem) {
        widgets.add(field);
      } else if (field is FormSection) {
        widgets.add(field);
      }
    }
    return widgets;
  }

  factory AdvancedFormGenerator.joinForms(
          List<AdvancedFormGenerator> controllers) =>
      AdvancedFormGenerator(
        controllers
            .map((AdvancedFormGenerator el) => el.getFields)
            .expand<FormFieldItem>((el) => el)
            .toList(),
      );
}
