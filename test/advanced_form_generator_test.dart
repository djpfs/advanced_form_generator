import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_form_generator/advanced_form_generator.dart';

void main() {
  test('create a new form', () {
    final List<dynamic> formFields = [
      FormFieldItem(
        label: 'test',
        mapKey: 'test',
        initialValue: 'test',
      ),
    ];
    final form = AdvancedFormGenerator(inputs: formFields);
    expect(form.getFields.length, 1);
  });
  test('test toMap method', () {
    final List<dynamic> formFields = [
      FormFieldItem(
        label: 'test',
        mapKey: 'test',
        initialValue: 'test',
      ),
    ];
    final form = AdvancedFormGenerator(inputs: formFields);
    expect(form.toMap(), {'test': 'test'});
  });
}
