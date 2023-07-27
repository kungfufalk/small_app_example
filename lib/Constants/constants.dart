import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const baseUri = 'localhost:8080';
const collectionUri = '$baseUri/collection';
const itemUri = '$baseUri/item';
const categoryUri = '$baseUri/category';
const itemsCrossAxis = 3;

final ThemeData myTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.robotoTextTheme(),
  iconTheme: const IconThemeData(
    color: Colors.blue,
    opacity: 0.8,
    size: 20,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,     // Button color
    textTheme: ButtonTextTheme.primary, // Button text color
  ),
);