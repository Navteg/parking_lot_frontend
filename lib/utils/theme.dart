import 'package:flutter/material.dart';

class ColorTheme {
  static const Color blackTheme = Color(0xFF000000);
  static const Color grayTheme = Color(0xFFC1C1C1);
  static const Color grayThemeLight = Color.fromARGB(255, 216, 216, 216);
  static const Color nearBlack = Color.fromARGB(255, 101, 100, 100);
  static const Color textfield = Color.fromARGB(131, 241, 240, 240);

  static const Color whiteTheme = Color(0xFFFFFFFF);
  static Color primary = Colors.deepPurple;

  static const Color errorBGColor = Color(0xFFEFDFDE);
  static const Color errorTextColor = Color(0xFFCA3535);
}

class FontTheme {
  // Heading
  static const double headingSize = 26.0;
  static const FontWeight headingWeight = FontWeight.w700;

  // Sub-heading
  static const double subheadingSize = 16.0;
  static const FontWeight subheadingWeight = FontWeight.w600;

  // Button
  static const double buttonFontSize = 18;
}
