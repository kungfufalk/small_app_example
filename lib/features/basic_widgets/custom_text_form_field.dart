import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberFormField extends TextFormField {
  final String? labelText;
  final TextEditingController customController;
  late final InputDecoration standardDecoration;

  CustomNumberFormField(
      {super.key, required this.customController, this.labelText}) {
    standardDecoration = InputDecoration(
      labelText: labelText,
    );
    TextFormField(
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
