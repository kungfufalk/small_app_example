import 'dart:io';

import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({super.key, this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Image.asset('assets/categoryThumbnail.png');
    } else {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
      );
    }
  }
}