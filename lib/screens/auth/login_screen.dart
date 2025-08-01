import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:adalat/constants/services/app_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/pop_up.dart';
import '../../constants/frontend_components/color_palette.dart';
import '../../constants/frontend_components/text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/navigation_widgets.dart';
import 'helpers/sign_up_hovering.dart';

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
      drawer: NavigationSidebar(
        selectedRoute: AppRouteConstants.login,
        onRouteSelected: (route) => GoRouter.of(context).go(route),
      ),
      body: LoadingOverlay(
        isLoading: authProvider.isLoading,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomContainer(
              padding: EdgeInsets.all(AppSpacingValues.largePadding),
              margin: EdgeInsets.all(AppSpacingValues.largePadding),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height,
                child: CustomForm(
                  formKey: _formKey,
                  fields: [
                    Text(
                      'Login to Adalaat',
                      style: AppTextStyles.headline1.copyWith(
                        fontSize: AppSpacingValues.largePadding,
                      ),
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    Text(
                      'All-in-one Court Management System',
                      style: AppTextStyles.bodyText.copyWith(),
                    ),
                    const SizedBox(height: AppSpacingValues.mediumMargin),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                    ),
                  ],
                  footerWidgets: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSpacingValues.mediumMargin),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSpacingValues.buttonPadding,
                              ),
                              height: 1,
                              color: AppColors.primaryColor,
                            ),
                            Text('or continue with'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSpacingValues.buttonPadding,
                              ),
                              height: 1,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacingValues.mediumMargin),
                        _buildButton(
                          icon: FaIcon(FontAwesomeIcons.google),
                          text: 'Continue with Google',
                          onPressed: () {},
                        ),
                        const SizedBox(height: AppSpacingValues.smallMargin),
                        _buildButton(
                          icon: FaIcon(FontAwesomeIcons.phone),
                          text: 'Continue with Phone',
                          onPressed: () {},
                        ),
                        const SizedBox(height: AppSpacingValues.smallMargin),
                        _buildButton(
                          icon: Icon(Icons.mail),
                          text: 'Continue with Mail',
                          onPressed: () {},
                        ),
                        const SizedBox(height: AppSpacingValues.smallMargin),
                        HoverSignupText(
                          onSignupClick: () {
                            GoRouter.of(context).go(AppRouteConstants.signup);
                          },
                        ),
                      ],
                    ),
                  ],
                  onSubmit: () async {
                    if (_formKey.currentState!.validate()) {
                      await authProvider.signIn(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (authProvider.errorMessage == null) {
                        GoRouter.of(context).go(AppRouteConstants.dashboard);
                      } else {
                        if (mounted) {
                          CommonPopUp(
                            title: 'Login Error',
                            message: authProvider.errorMessage!,
                            primaryButtonText: 'Try Again',
                            onPrimaryPressed: () => Navigator.pop(context),
                          );
                        }
                      }
                    }
                  },
                  buttonHeight: 40,
                  buttonWidth: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            ),
            CustomContainer(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required Widget icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey.shade300),
      ),
      icon: icon,
      label: Text(text),
      onPressed: onPressed,
    );
  }
}
