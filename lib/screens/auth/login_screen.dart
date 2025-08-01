import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';
import '../../widgets/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviderVM>();
    return Scaffold(
      body: LoadingOverlay(
        isLoading: authProvider.isLoading,
        child: CustomContainer(
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
            ],
            onSubmit: () async {
              // if (_formKey.currentState!.validate()) {
              //   await authProvider.signIn(
              //     _emailController.text,
              //     _passwordController.text,
              //   );
              //   if (authProvider.errorMessage == null) {
              //     GoRouter.of(context).go(AppRoutes.dashboard);
              //   } else {
              //     if (mounted) {
              //       CommonPopUp(
              //         title: 'Login Error',
              //         message: authProvider.errorMessage!,
              //         primaryButtonText: 'Try Again',
              //         onPrimaryPressed: () => Navigator.pop(context),
              //       );
              //     }
              //   }
              // }
            },
          ),
        ),
      ),
    );
  }
}
