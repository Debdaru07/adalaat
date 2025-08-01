import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:adalat/constants/services/app_route.dart';
import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';

class NavigationSidebar extends StatelessWidget {
  final String selectedRoute;
  final Function(String) onRouteSelected;

  const NavigationSidebar({
    super.key,
    required this.selectedRoute,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Text(
              'Adalat AI',
              style: AppTextStyles.headline2.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Dashboard', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.dashboard,
            onTap: () => onRouteSelected(AppRouteConstants.dashboard),
          ),
          ListTile(
            title: Text('Cases', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.cases,
            onTap: () => onRouteSelected(AppRouteConstants.cases),
          ),
          ListTile(
            title: Text('Login', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.login,
            onTap: () => onRouteSelected(AppRouteConstants.login),
          ),
          ListTile(
            title: Text('Sign Up', style: AppTextStyles.bodyText),
            selected: selectedRoute == AppRouteConstants.signup,
            onTap: () => onRouteSelected(AppRouteConstants.signup),
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
