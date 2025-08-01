import 'package:flutter/material.dart';

import '../constants/frontend_components/box_decorations.dart';
import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/spacing_values.dart';
import '../constants/frontend_components/text_styles.dart';
import '../constants/services/case_status.dart';
import '../services/firebase/cases/case_handler.dart';
import '../services/network/network_service.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseHandler = CaseHandler(NetworkService());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Cases',
          style: AppTextStyles.headline1.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacingValues.screenPadding),
        child: FutureBuilder<NetworkResponse<List<Map<String, dynamic>>>>(
          future: caseHandler.getAllCases(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data!.state == ApiState.error) {
              return Center(
                child: Text(
                  'Error: ${snapshot.data!.error} (Code: ${snapshot.data!.statusCode})',
                  style: AppTextStyles.bodyText.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
              );
            }
            final cases = snapshot.data?.data ?? [];
            return ListView.builder(
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final caseData = cases[index];
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppSpacingValues.mediumMargin,
                  ),
                  decoration: AppDecorations.cardDecoration,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      AppSpacingValues.cardPadding,
                    ),
                    title: Text(
                      caseData['title'],
                      style: AppTextStyles.headline2,
                    ),
                    subtitle: Text(
                      caseData['status'],
                      style: AppTextStyles.caption,
                    ),
                    onTap: () async {
                      final response = await caseHandler.updateCase(
                        caseData['caseId'],
                        status: CaseStatuses.inProgress,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response.state == ApiState.success
                                  ? 'Case updated successfully'
                                  : 'Error: ${response.error}',
                              style: AppTextStyles.bodyText.copyWith(
                                color:
                                    response.state == ApiState.success
                                        ? AppColors.successColor
                                        : AppColors.errorColor,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
