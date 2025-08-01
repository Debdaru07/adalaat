import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:flutter/material.dart';

import '../constants/frontend_components/box_decorations.dart';
import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';
import '../constants/services/case_status.dart';
import '../constants/services/user_account_status.dart';
import 'layout_widgets.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> rows;
  final Function(Map<String, dynamic>)? onRowTap;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            columns
                .map(
                  (col) => DataColumn(
                    label: Text(col, style: AppTextStyles.headline2),
                  ),
                )
                .toList(),
        rows:
            rows
                .map(
                  (row) => DataRow(
                    cells:
                        row.values
                            .map(
                              (value) => DataCell(
                                Text(
                                  value.toString(),
                                  style: AppTextStyles.bodyText,
                                ),
                              ),
                            )
                            .toList(),
                    onSelectChanged:
                        onRowTap != null ? (selected) => onRowTap!(row) : null,
                  ),
                )
                .toList(),
        headingRowColor: WidgetStatePropertyAll(
          AppColors.primaryColor.withOpacity(0.1),
        ),
        dataRowColor: WidgetStatePropertyAll(Colors.white),
        decoration: AppDecorations.cardDecoration,
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  Color _getStatusColor() {
    switch (status) {
      case CaseStatuses.pending:
      case UserAccountStatuses.pendingVerification:
        return AppColors.accentColor;
      case CaseStatuses.inProgress:
      case UserAccountStatuses.active:
        return AppColors.successColor;
      case CaseStatuses.closed:
      case UserAccountStatuses.deactivated:
        return AppColors.textColor.withOpacity(0.5);
      case UserAccountStatuses.suspended:
        return AppColors.errorColor;
      default:
        return AppColors.textColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(status, style: AppTextStyles.caption),
      backgroundColor: _getStatusColor().withOpacity(0.2),
      labelStyle: AppTextStyles.caption.copyWith(color: _getStatusColor()),
    );
  }
}

class Timeline extends StatelessWidget {
  final List<Map<String, String>>
  events; // e.g., {'title': 'Case Filed', 'date': '2025-08-01'}

  const Timeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children:
            events.asMap().entries.map((entry) {
              final index = entry.key;
              final event = entry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
                title: Text(
                  event['title'] ?? '',
                  style: AppTextStyles.bodyText,
                ),
                subtitle: Text(
                  event['date'] ?? '',
                  style: AppTextStyles.caption,
                ),
              );
            }).toList(),
      ),
    );
  }
}

class ExpandableListItem extends StatelessWidget {
  final String title;
  final Widget expandedContent;
  final bool isExpanded;

  const ExpandableListItem({
    super.key,
    required this.title,
    required this.expandedContent,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ExpansionTile(
        title: Text(title, style: AppTextStyles.headline2),
        initiallyExpanded: isExpanded,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacingValues.cardPadding),
            child: expandedContent,
          ),
        ],
      ),
    );
  }
}
