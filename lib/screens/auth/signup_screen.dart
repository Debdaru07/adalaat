import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/services/app_route.dart';
import '../../constants/services/user_role.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/navigation_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  String _role = UserRoles.judge;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviderVM>();
    return Scaffold(
      drawer: NavigationSidebar(
        selectedRoute: AppRouteConstants.login,
        onRouteSelected: (route) => GoRouter.of(context).go(route),
      ),
      body: LoadingOverlay(
        isLoading: authProvider.isLoading,
        child: CustomContainer(
          decoration: null,
          child: CustomForm(
            formKey: _formKey,
            fields: [
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                validator:
                    (value) => value!.isEmpty ? 'Email is required' : null,
              ),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                obscureText: true,
                validator:
                    (value) => value!.isEmpty ? 'Password is required' : null,
              ),
              CustomTextField(
                label: 'Full Name',
                controller: _fullNameController,
                validator:
                    (value) => value!.isEmpty ? 'Full Name is required' : null,
              ),
              CustomDropdown(
                label: 'Role',
                options: UserRoles.values,
                value: _role,
                onChanged: (value) => setState(() => _role = value!),
              ),
            ],
            onSubmit: () async {
              if (_formKey.currentState!.validate()) {
                await authProvider.signUp(
                  _emailController.text,
                  _passwordController.text,
                  _fullNameController.text,
                  _role,
                );
                if (authProvider.errorMessage == null) {
                  Navigator.pop(context); // Return to login
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
