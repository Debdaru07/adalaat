import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/state_manager.dart';
import '../../widgets/layout_widgets.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/specialized_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseProvider = context.watch<CaseProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Adalat AI Dashboard')),
      body: LoadingOverlay(
        isLoading: caseProvider.isLoading,
        child:
            caseProvider.errorMessage != null
                ? Text('Error')
                : ResponsiveGrid(
                  children: [
                    AnalyticsDashboardWidget(
                      title: 'Total Cases',
                      value: '150',
                      icon: Icons.cases,
                    ),
                    AnalyticsDashboardWidget(
                      title: 'Pending Cases',
                      value: '30',
                      icon: Icons.hourglass_empty,
                    ),
                    AnalyticsDashboardWidget(
                      title: 'Closed Cases',
                      value: '120',
                      icon: Icons.check_circle,
                    ),
                  ],
                ),
      ),
    );
  }
}
