import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';

class CommonPopUp extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const CommonPopUp({
    super.key,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyles.headline2),
      content: Text(message, style: AppTextStyles.bodyText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      actions: [
        if (secondaryButtonText != null)
          TextButton(
            onPressed: onSecondaryPressed ?? () => Navigator.pop(context),
            child: Text(
              secondaryButtonText!,
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        if (primaryButtonText != null)
          ElevatedButton(
            onPressed: onPrimaryPressed ?? () => Navigator.pop(context),
            child: Text(primaryButtonText!, style: AppTextStyles.buttonText),
          ),
      ],
    );
  }

  // Static method to show the popup
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText,
    VoidCallback? onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => CommonPopUp(
            title: title,
            message: message,
            primaryButtonText: primaryButtonText,
            onPrimaryPressed: onPrimaryPressed,
            secondaryButtonText: secondaryButtonText,
            onSecondaryPressed: onSecondaryPressed,
          ),
    );
  }
}
