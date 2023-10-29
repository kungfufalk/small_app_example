import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueButton<T> extends StatelessWidget {
  const AsyncValueButton(
      {Key? key, required this.value, required this.data, required this.error})
      : super(key: key);
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace) error;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stackTrace) => error(err, stackTrace),
    );
  }
}
