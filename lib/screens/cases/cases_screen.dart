import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../constants/services/case_status.dart';
import '../../providers/state_manager.dart';
import '../../widgets/data_display_widgets.dart';
import '../../widgets/filter_sort_widgets.dart';
import '../../widgets/loading_overlay.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseProvider = context.watch<CaseProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cases'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FilterScreen(
                          filterOptions: CaseStatuses.values,
                          selectedOption:
                              caseProvider.cases.isNotEmpty
                                  ? caseProvider.cases[0]['status']
                                  : '',
                          onOptionSelected: caseProvider.setFilter,
                        ),
                  ),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SortScreen(
                          sortOptions: ['Date Filed', 'Title'],
                          selectedOption: '',
                          // caseProvider.setFilter,
                          onSortSelected: caseProvider.setSortBy,
                        ),
                  ),
                ),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: caseProvider.isLoading,
        child:
            caseProvider.errorMessage != null
                ? Text('Error')
                : Column(
                  children: [
                    SearchBar(
                      hintText: 'Search Cases',
                      onSubmitted: caseProvider.setFilter,
                    ),
                    Expanded(
                      child: CustomDataTable(
                        columns: ['ID', 'Title', 'Status'],
                        rows: caseProvider.cases,
                        onRowTap:
                            (row) =>
                                GoRouter.of(context).go('/case/${row['id']}'),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
