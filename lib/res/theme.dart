import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Inter'
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return lightTheme(context).copyWith(brightness: Brightness.dark);
  }
}
