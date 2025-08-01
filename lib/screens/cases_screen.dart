import 'package:flutter/material.dart';

import '../constants/frontend_components/ui_components.dart';
import '../constants/services/case_status.dart';
import '../services/firebase/cases/case_handler.dart';
import '../services/network/network_service.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseHandler = CaseHandler(NetworkService());

    return Scaffold(
      backgroundColor: UIConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: UIConstants.primaryColor,
        title: Text(
          'Cases',
          style: UIConstants.headline1.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.screenPadding),
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
                  style: UIConstants.bodyText.copyWith(
                    color: UIConstants.errorColor,
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
                    bottom: UIConstants.mediumMargin,
                  ),
                  decoration: UIConstants.cardDecoration,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      UIConstants.cardPadding,
                    ),
                    title: Text(
                      caseData['title'],
                      style: UIConstants.headline2,
                    ),
                    subtitle: Text(
                      caseData['status'],
                      style: UIConstants.caption,
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
                              style: UIConstants.bodyText.copyWith(
                                color:
                                    response.state == ApiState.success
                                        ? UIConstants.successColor
                                        : UIConstants.errorColor,
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
