import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: GoogleFonts.interTextTheme()
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return lightTheme(context).copyWith(brightness: Brightness.dark);
  }
}
