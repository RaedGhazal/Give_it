import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

//default theme colors.
const grey = const Color(0xff707070);
const lightGrey = const Color(0xff989898);

//default app theme.
final defaultTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: GoogleFonts.playfairDisplay(
      color: grey,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    headline1: GoogleFonts.playfairDisplay(
      color: grey,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.playfairDisplay(
      color: grey,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    headline5: GoogleFonts.playfairDisplay(
        color: lightGrey, fontSize: 20, fontWeight: FontWeight.bold),
    headline6: GoogleFonts.playfairDisplay(
      color: lightGrey,
      fontSize: 35,
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(
      color: grey,
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.playfairDisplay(
        color: grey,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.lightBlue,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
  ),
  indicatorColor: grey,
);
