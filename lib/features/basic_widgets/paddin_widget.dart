import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({super.key, required this.child});

  static const EdgeInsets materialPadding = EdgeInsets.all(16.0);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: materialPadding,
      child: child,
    );
  }
}