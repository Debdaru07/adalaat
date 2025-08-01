import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:adalat/constants/services/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';

class NavigationDrawer extends StatelessWidget {
  final String selectedRoute;
  final Function(String) onRouteSelected;

  const NavigationDrawer({
    super.key,
    required this.selectedRoute,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(AppSpacingValues.screenPadding),
        children: [
          ListTile(
            title: Text('Dashboard', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.dashboard,
            selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
            onTap: () => onRouteSelected(AppRouteConstants.dashboard),
          ),
          ListTile(
            title: Text('Cases', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.cases,
            selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
            onTap: () => onRouteSelected(AppRouteConstants.cases),
          ),
          ListTile(
            title: Text('Logout', style: AppTextStyles.bodyText),
            onTap: () {
              // Implement logout with UserHandler
              GoRouter.of(context).go(AppRouteConstants.login);
            },
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final String selectedRoute;
  final Function(String) onRouteSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedRoute,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedRoute == AppRouteConstants.dashboard ? 0 : 1,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColor.withOpacity(0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.cases), label: 'Cases'),
      ],
      onTap: (index) {
        final route =
            index == 0 ? AppRouteConstants.dashboard : AppRouteConstants.cases;
        onRouteSelected(route);
      },
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;
  final int selectedIndex;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      labelStyle: AppTextStyles.bodyText,
      unselectedLabelStyle: AppTextStyles.bodyText.copyWith(
        color: AppColors.textColor.withOpacity(0.5),
      ),
      labelColor: AppColors.primaryColor,
      indicatorColor: AppColors.primaryColor,
      onTap: onTabSelected,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSecondary ? AppColors.secondaryColor : AppColors.primaryColor,
        padding: EdgeInsets.all(AppSpacingValues.buttonPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: isLoading ? null : onPressed,
      child:
          isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(label, style: AppTextStyles.buttonText),
    );
  }
}
