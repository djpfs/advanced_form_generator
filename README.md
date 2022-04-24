# **[advanced_form_generator](https://github.com/djpfs/advanced_form_generator)**

# Installation

In the `dependencies:` section of your _pubspec.yaml_ , add the following line:

`advanced_form_generator: ^0.0.2`

# Usage

```dart
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

```

# Methods

## **toMap()**

Returns a [Map] with all the fields and their values

###### **Parameters**

[ignoreEmpty] - if true, will ignore empty fields - default: false

[emptyValue] - value to be used if [ignoreEmpty] is false and the field is empty - default: false

[ignoreEmpty] and [emptyValue] if active together, only [ignoreEmpty] will be considere

```dart
// Declare a form
AdvancedFormGenerator formGenerator = AdvancedFormGenerator(inputs: [
      FormFieldItem(
        label: 'E-mail',
        required: true,
        mapKey: 'email',
      ),FormFieldItem(
        label: 'Senha',
        mapKey: 'password',
      ),
]);

// Returns a map with the form's properties and values
**formGenerator.toMap();**

// Example
/*
{
	'email': '',
	'password: ''
}
*/
```

**render()**

Returns a [List] with all the widgets to render

```dart
// Declare a form
AdvancedFormGenerator formGenerator = AdvancedFormGenerator(inputs: [
      FormFieldItem(
        label: 'E-mail',
        required: true,
        mapKey: 'email',
      ),FormFieldItem(
        label: 'Senha',
        mapKey: 'password',
      ),
]);

...

// Inside widgets
...
Column(
        children: formGenerator.render(),
      ),
...
// or
...
Column(
	children: [
		Text('Example'),
		...formGenerator.render(),
	]
),
...
```

## reset()

Resets all the [TextEditingController]s inside [FormFieldItem]s and [IFormFieldItem]s to empty

# How to create a custom FormFieldItem widget

```dart
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

```

# How to change the style of [FormFieldItem]?

You can do it individually, like this:

```
FormFieldItem(
        label: 'E-mail',
        required: true,
        mapKey: 'email',
        decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 18, color: Colors.grey[900]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      )
```

or for all:

```
AdvancedFormGenerator formGenerator = AdvancedFormGenerator(inputs: [
      FormFieldItem(
        label: 'E-mail',
        required: true,
        mapKey: 'email',
      ),FormFieldItem(
        label: 'Senha',
        mapKey: 'password',
      ),
     ],
decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 18, color: Colors.grey[900]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
      ),
);
```

# Notes

> Do not place the [FormFieldItem] and [IFormFieldItem] inside any other Widget, or it will not be recognized as a text field.

> If you are not using reactive state management, you may need to do a hot reload for changes made to the form code to take effect.

> You can change the margin between [FormField Item] by passing the 'margin' parameter in the form's constructor.
