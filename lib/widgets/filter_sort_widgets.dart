import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:flutter/material.dart';

import '../constants/frontend_components/text_styles.dart';
import 'layout_widgets.dart';

class FilterScreen extends StatelessWidget {
  final List<String> filterOptions;
  final String selectedOption;
  final Function(String) onOptionSelected;

  const FilterScreen({
    super.key,
    required this.filterOptions,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
          style: AppTextStyles.headline1.copyWith(color: Colors.white),
        ),
      ),
      body: CustomContainer(
        child: Column(
          children: [
            Text('Filter By', style: AppTextStyles.headline2),
            SizedBox(height: AppSpacingValues.mediumMargin),
            DropdownButton<String>(
              value: selectedOption,
              items:
                  filterOptions
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option, style: AppTextStyles.bodyText),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) onOptionSelected(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SortScreen extends StatelessWidget {
  final List<String> sortOptions;
  final String selectedOption;
  final Function(String) onSortSelected;

  const SortScreen({
    super.key,
    required this.sortOptions,
    required this.selectedOption,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sort',
          style: AppTextStyles.headline1.copyWith(color: Colors.white),
        ),
      ),
      body: CustomContainer(
        child: Column(
          children: [
            Text('Sort By', style: AppTextStyles.headline2),
            SizedBox(height: AppSpacingValues.mediumMargin),
            DropdownButton<String>(
              value: selectedOption,
              items:
                  sortOptions
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option, style: AppTextStyles.bodyText),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) onSortSelected(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
