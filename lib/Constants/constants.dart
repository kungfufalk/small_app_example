import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const baseUriDeprecated = 'http://192.168.178.59:8080';
const collectionUri = '$baseUriDeprecated/collection';
const itemUri = '$baseUriDeprecated/item';
const categoryUri = '$baseUriDeprecated/category';
const itemsCrossAxis = 3;

const hostAddress = '192.168.178.59';
const grpcPort = 50051;

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