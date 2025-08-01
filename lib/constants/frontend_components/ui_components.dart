import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIConstants {
  // Colors
  static const Color primaryColor = Color(0xFF1A3C6D); // Navy Blue
  static const Color secondaryColor = Color(0xFF26A69A); // Teal
  static const Color backgroundColor = Color(0xFFF5F6F5); // Off-White
  static const Color textColor = Color(0xFF333333); // Dark Gray
  static const Color accentColor = Color(0xFFFFD700); // Gold
  static const Color errorColor = Color(0xFFEF5350); // Soft Red
  static const Color successColor = Color(0xFF4CAF50); // Green

  // Text Styles
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

  // Decorations
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration secondaryButtonDecoration = BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.circular(8),
  );

  static InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: textColor.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: textColor.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // Spacing Values
  static const double smallPadding =
      8.0; // For tight spaces (e.g., between form fields)
  static const double mediumPadding =
      16.0; // Standard padding for cards, buttons
  static const double largePadding = 24.0; // For section spacing
  static const double smallMargin = 8.0; // For small gaps between widgets
  static const double mediumMargin = 16.0; // Standard margin for layouts
  static const double largeMargin = 24.0; // For major section separation
  static const double buttonPadding = 12.0; // Internal padding for buttons
  static const double cardPadding = 16.0; // Internal padding for cards
  static const double screenPadding = 24.0; // Screen edge padding
}
