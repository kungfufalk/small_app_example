import 'package:flutter/cupertino.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
