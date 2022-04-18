// import 'package:advanced_form_generator/models/FormFieldItem.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:advanced_form_generator/advanced_form_generator.dart';

// void main() {
//   test('add fields to form', () {
//     final List<FormFieldItem> formFields = [
//       FormFieldItem(
//         title: 'test',
//         initialValue: 'test',
//       ),
//     ];
//     final form = FormController(formFields);
//     expect(form.getFields.length, 1);
//     form.addField(FormFieldItem(title: 'test2'));
//     expect(form.getFields.length, 2);
//   });
//   test('single form to map', () {
//     final form = FormController([
//       FormFieldItem(
//         title: 'test',
//         initialValue: 'test',
//       ),
//       FormFieldItem(
//         title: 'test2',
//       ),
//     ]);
//     expect(form.toMap(), {'test': 'test', 'test2': null});
//     expect(form.toMap(emptyToNull: true), {'test': 'test', 'test2': null});
//     expect(form.toMap(ignoreEmpty: true), {'test': 'test'});
//   });
//   test('join forms', () {
//     final form = FormController([
//       FormFieldItem(
//         title: 'test',
//         initialValue: 'test',
//       ),
//     ]);
//     final form2 = FormController([
//       FormFieldItem(
//         title: 'test2',
//       ),
//     ]);
//     final formJoin = FormController.joinForms([form, form2]);
//     expect(formJoin.getFields.length, 2);
//     debugPrint(formJoin.toMap(emptyToNull: true));
//     // expect(formJoin.toMap(emptyToNull: true), {'test': 'test', 'test2': null});
//     // expect(formJoin.toMap(ignoreEmpty: true), {'test': 'test'});
//   });
// }
