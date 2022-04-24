import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:advanced_form_generator/widgets/FormFieldSection.dart';
import 'package:advanced_form_generator/advanced_form_generator.dart';
import 'package:advanced_form_generator/widgets/IFormFieldItem.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget implements IFormFieldItem {
  @override
  TextEditingController? controller;

  @override
  String? initialValue;
  @override
  String mapKey;

  @override
  InputDecoration? decoration;

  @override
  String label;

  CustomText({
    Key? key,
    this.controller,
    this.initialValue,
    this.hint,
    required this.label,
    required this.mapKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration,
      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
    );
  }

  @override
  String? hint;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late final AdvancedFormGenerator formGenerator;

  @override
  void initState() {
    formGenerator = AdvancedFormGenerator(
      inputs: [
        FormFieldItem(
          label: 'Name',
          required: true,
          mapKey: 'name',
        ),
        FormFieldItem(
          label: 'E-mail',
          mapKey: 'email',
          required: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'E-mail is required';
            }
            return null;
          },
        ),

        /// Example of a custom widget
        const FormFieldSection(title: 'Security section'),

        FormFieldItem(
          label: 'Password',
          mapKey: 'password',
          obscureText: true,
          required: true,
        ),
        FormFieldItem(
          label: 'Password Confirmation',
          mapKey: 'passwordConfirm',
          obscureText: true,
          required: true,
        ),
        CustomText(
          mapKey: 'custom',
          label: 'Custom Text Field',
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint(formGenerator.toMap().toString());
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: formGenerator.render(),
          ),
        ),
      ),
    );
  }
}
