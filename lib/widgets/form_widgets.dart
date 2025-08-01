import 'package:adalat/constants/frontend_components/box_decorations.dart';
import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';
import 'layout_widgets.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> fields;
  final VoidCallback onSubmit;
  final String submitButtonText;

  const CustomForm({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.submitButtonText = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...fields,
            SizedBox(height: AppSpacingValues.mediumMargin),
            ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.all(AppSpacingValues.buttonPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(submitButtonText, style: AppTextStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingValues.smallMargin),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: AppDecorations.inputDecoration,
        style: AppTextStyles.bodyText,
        validator: validator,
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.options,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingValues.smallMargin),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: AppDecorations.inputDecoration.copyWith(
          labelText: label,
          labelStyle: AppTextStyles.bodyText,
        ),
        style: AppTextStyles.bodyText,
        items:
            options
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option, style: AppTextStyles.bodyText),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingValues.smallMargin),
      child: InkWell(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: InputDecorator(
          decoration: AppDecorations.inputDecoration.copyWith(
            labelText: label,
            labelStyle: AppTextStyles.bodyText,
          ),
          child: Text(
            selectedDate != null
                ? '${selectedDate!.toLocal()}'.split(' ')[0]
                : 'Select Date',
            style: AppTextStyles.bodyText,
          ),
        ),
      ),
    );
  }
}
