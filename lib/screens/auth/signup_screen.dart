import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:adalat/constants/services/app_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/pop_up.dart';
import '../../constants/frontend_components/color_palette.dart';
import '../../constants/frontend_components/text_styles.dart';
import '../../constants/services/user_role.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/layout_widgets.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/navigation_widgets.dart';

class HoverLoginText extends StatelessWidget {
  final VoidCallback onLoginClick;

  const HoverLoginText({super.key, required this.onLoginClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account? ', style: AppTextStyles.bodyText),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onLoginClick,
            child: const Text(
              'Login',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
        selectedRoute: AppRouteConstants.signup,
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
                      'Sign Up for Adalaat',
                      style: AppTextStyles.headline1.copyWith(
                        fontSize: AppSpacingValues.largePadding,
                      ),
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    Text(
                      'Join the All-in-one Court Management System',
                      style: AppTextStyles.bodyText.copyWith(),
                    ),
                    const SizedBox(height: AppSpacingValues.mediumMargin),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Email is required'
                                  : null,
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Password is required'
                                  : null,
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    CustomTextField(
                      label: 'Full Name',
                      controller: _fullNameController,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Full Name is required'
                                  : null,
                    ),
                    const SizedBox(height: AppSpacingValues.smallMargin),
                    CustomDropdown(
                      label: 'Role',
                      options: UserRoles.values,
                      value: _role,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _role = value);
                        }
                      },
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
                        HoverLoginText(
                          onLoginClick: () {
                            GoRouter.of(context).go(AppRouteConstants.login);
                          },
                        ),
                      ],
                    ),
                  ],
                  onSubmit: () async {
                    if (_formKey.currentState!.validate()) {
                      await authProvider.signUp(
                        _emailController.text,
                        _passwordController.text,
                        _fullNameController.text,
                        _role.toString().split('.').last,
                      );
                      if (authProvider.errorMessage == null) {
                        GoRouter.of(context).go(AppRouteConstants.login);
                      } else {
                        if (mounted) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => CommonPopUp(
                                  title: 'Signup Error',
                                  message: authProvider.errorMessage!,
                                  primaryButtonText: 'Try Again',
                                  onPrimaryPressed:
                                      () => Navigator.pop(context),
                                ),
                          );
                        }
                      }
                    }
                  },
                  buttonHeight: 40,
                  buttonWidth: MediaQuery.of(context).size.width * 0.25,
                  submitButtonText: 'Sign Up',
                ),
              ),
            ),
            CustomContainer(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.25,
                      child: Image.asset(
                        'assets/images/login_bg.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Aap Ki Adalaat, Order Order !',
                        style: AppTextStyles.documentText,
                      ),
                    ),
                  ],
                ),
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
