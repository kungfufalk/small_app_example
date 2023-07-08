import 'dart:io';

import 'package:flutter/material.dart';

class ItemThumbnail extends StatelessWidget {
  const ItemThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.file(File('item.jpg'))
    );
  }
}
