import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';

// Enum to define popup types
enum PopupType { success, error, warning, none }

class CommonPopUp extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final PopupType popupType;

  const CommonPopUp({
    super.key,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.popupType = PopupType.none,
  });

  // Method to get icon based on popup type
  IconData? _getIconForType() {
    switch (popupType) {
      case PopupType.success:
        return Icons.check_circle;
      case PopupType.error:
        return Icons.error;
      case PopupType.warning:
        return Icons.warning;
      case PopupType.none:
        return null;
    }
  }

  // Method to get color based on popup type
  Color _getColorForType() {
    switch (popupType) {
      case PopupType.success:
        return Colors.green;
      case PopupType.error:
        return Colors.red;
      case PopupType.warning:
        return Colors.orange;
      case PopupType.none:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForType();
    return AlertDialog(
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: _getColorForType(), size: 24),
            const SizedBox(width: 8), // Spacing between icon and title
          ],
          Expanded(child: Text(title, style: AppTextStyles.headline2)),
        ],
      ),
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
    PopupType popupType = PopupType.none,
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
            popupType: popupType,
          ),
    );
  }
}
