import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.controller, this.labelText}) {
    standardDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.black54,
      labelText: labelText,
    );
  }

  final String? labelText;
  final TextEditingController controller;
  late final InputDecoration standardDecoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: standardDecoration,
      controller: controller,
    );
  }
}

class CustomNumberFormField extends StatelessWidget {
  CustomNumberFormField({super.key, required this.controller, this.labelText}) {
    standardDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.black54,
      labelText: labelText,
    );
  }

  final String? labelText;
  final TextEditingController controller;
  late final InputDecoration standardDecoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: standardDecoration,
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}
