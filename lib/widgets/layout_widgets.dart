import 'package:adalat/constants/frontend_components/box_decorations.dart';
import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:adalat/constants/frontend_components/text_styles.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;

  const CustomContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(AppSpacingValues.cardPadding),
      margin: margin ?? EdgeInsets.all(AppSpacingValues.mediumMargin),
      decoration: decoration ?? AppDecorations.cardDecoration,
      child: child,
    );
  }
}

class SectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets? padding;

  const SectionWrapper({
    super.key,
    required this.title,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: padding ?? EdgeInsets.all(AppSpacingValues.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headline2),
          SizedBox(height: AppSpacingValues.smallMargin),
          child,
        ],
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      padding: EdgeInsets.all(AppSpacingValues.screenPadding),
      mainAxisSpacing: AppSpacingValues.mediumMargin,
      crossAxisSpacing: AppSpacingValues.mediumMargin,
      children: children,
    );
  }
}
