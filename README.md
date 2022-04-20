# **[advanced_form_generator](https://github.com/djpfs/advanced_form_generator)**

## Installation

In the `dependencies:` section of your _pubspec.yaml_ , add the following line:

`advanced_form_generator: ^0.0.1`

## Usage

`formGenerator = AdvancedFormGenerator([ `

`FormFieldItem( label: 'Nome completo', required: true, mapKey: 'name', ), `

`FormFieldItem( label: 'E-mail', mapKey: 'email', required: true, validator: (String? value, bool? item) { if (value == null || value.isEmpty) { return 'E-mail é obrigatório'; } return null; }, ),`
