import 'package:flutter/material.dart';

import 'color_palette.dart';
import 'spacing_values.dart';

class AppDecorations {
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
    color: AppColors.primaryColor,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration secondaryButtonDecoration = BoxDecoration(
    color: AppColors.secondaryColor,
    borderRadius: BorderRadius.circular(8),
  );

  static InputDecorationTheme inputDecoration = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.errorColor),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacingValues.mediumPadding,
      vertical: AppSpacingValues.smallPadding,
    ),
  );
}
