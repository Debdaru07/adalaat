import 'package:flutter/material.dart';

import '../constants/case_status.dart';
import '../services/firebase/cases/case_handler.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseHandler = CaseHandler();

    return Scaffold(
      appBar: AppBar(title: const Text('Cases')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: caseHandler.getAllCases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final cases = snapshot.data ?? [];
          return ListView.builder(
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final caseData = cases[index];
              return ListTile(
                title: Text(caseData['title']),
                subtitle: Text(caseData['status']),
                onTap: () async {
                  await caseHandler.updateCase(
                    caseData['caseId'],
                    status: CaseStatuses.inProgress,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
