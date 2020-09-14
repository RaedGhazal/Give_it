import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

//default theme colors.
const grey = const Color(0xff707070);
const lightGrey = const Color(0xff989898);

//default app theme.
final defaultTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    textTheme: TextTheme(
      headline6: GoogleFonts.playfairDisplay(
        color: grey,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
