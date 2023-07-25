import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/API/item_api.dart';
import 'package:small_app_example/Widgets/collection_view.dart';
import 'package:small_app_example/Widgets/item_view.dart';

void main() {
  runApp(ProviderScope(
      overrides: [itemAPIRepository.overrideWithValue(ItemDummyApi())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      color: Colors.redAccent,
      home: const CollectionView(),
    );
  }
}

