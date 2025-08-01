import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: AppColors.textColor.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          ),
      ],
    );
  }
}
