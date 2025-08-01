import 'package:go_router/go_router.dart';

import '../../screens/case_details/case_details.dart';
import '../../screens/cases_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/signup_screen.dart';
import '../../screens/users/users_screen.dart';

class AppRouteConstants {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String cases = '/cases';
  static const String caseDetails = '/case_details';
  static const String users = '/users';
}

class AppRouter {
  static GoRouter routing = GoRouter(
    initialLocation: AppRouteConstants.login,
    routes: [
      GoRoute(
        path: AppRouteConstants.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.cases,
        builder: (context, state) => const CasesScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.cases,
        builder: (context, state) => const CaseDetails(),
      ),
      GoRoute(
        path: AppRouteConstants.users,
        builder: (context, state) => const UsersScreen(),
      ),
    ],
  );
}
