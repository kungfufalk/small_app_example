import 'package:flutter/material.dart';

class NullOrDataWidget<T> extends StatelessWidget {
  const NullOrDataWidget(
      {super.key, required this.data, required this.value, required this.nullWidget});

  final T? value;
  final Widget Function(T) data;
  final Widget Function() nullWidget;

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return nullWidget();
    } else {
      return data(value as T);
    }
  }
}