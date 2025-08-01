import 'package:adalat/constants/frontend_components/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../constants/frontend_components/color_palette.dart';

class HoverSignupText extends StatefulWidget {
  final VoidCallback onSignupClick;

  const HoverSignupText({super.key, required this.onSignupClick});

  @override
  _HoverSignupTextState createState() => _HoverSignupTextState();
}

class _HoverSignupTextState extends State<HoverSignupText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onSignupClick,
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12),
                children: [
                  const TextSpan(text: 'Don’t have an account, yet? '),
                  TextSpan(
                    text: 'Sign up for free',
                    style: AppTextStyles.caption.copyWith(
                      color:
                          _isHovering
                              ? AppColors.primaryColor
                              : AppColors.textColor,
                      decoration: _isHovering ? TextDecoration.underline : null,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
