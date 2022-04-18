import 'package:advanced_form_generator/widgets/FormFieldItem.dart';
import 'package:advanced_form_generator/advanced_form_generator.dart';
import 'package:advanced_form_generator/widgets/FormSection.dart';
import 'package:flutter/material.dart';

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
    formGenerator = AdvancedFormGenerator([
      FormFieldItem(
        label: 'Nome completo',
        required: true,
        mapKey: 'name',
      ),
      FormFieldItem(
        label: 'E-mail',
        mapKey: 'email',
        required: true,
        validator: (String? value, bool? item) {
          if (value == null || value.isEmpty) {
            return 'E-mail é obrigatório';
          }
          return null;
        },
      ),
      const FormSection(title: 'Segurança'),
      FormFieldItem(
        label: 'Senha',
        mapKey: 'password',
      ),
      FormFieldItem(
        label: 'Confirmar senha',
        mapKey: 'passwordConfirm',
        obscureText: true,
      ),
    ]);
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
