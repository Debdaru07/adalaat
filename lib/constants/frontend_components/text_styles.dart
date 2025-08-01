import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static const Color textColor = Color(0xFF333333);
  static TextStyle headline1 = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: 0.5,
  );

  static TextStyle headline2 = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: 0.5,
  );

  static TextStyle bodyText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textColor,
    letterSpacing: 0.2,
  );

  static TextStyle caption = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: textColor.withOpacity(0.7),
  );

  static TextStyle buttonText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle documentText = GoogleFonts.notoSerif(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textColor,
  );
}
