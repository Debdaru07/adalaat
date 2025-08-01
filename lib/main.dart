import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/frontend_components/box_decorations.dart';
import 'constants/frontend_components/color_palette.dart';
import 'constants/frontend_components/spacing_values.dart';
import 'constants/frontend_components/text_styles.dart';
import 'constants/services/app_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AdalatAI());
}

class AdalatAI extends StatelessWidget {
  const AdalatAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Adalat AI',
      routerConfig: AppRouter.routing,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor, // Navy Blue (#1A3C6D)
        scaffoldBackgroundColor:
            AppColors.backgroundColor, // Off-White (#F5F6F5)
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor, // Teal (#26A69A)
          error: AppColors.errorColor, // Soft Red (#EF5350)
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.headline1, // Roboto, 28, Bold
          displayMedium: AppTextStyles.headline2, // Roboto, 24, Medium
          bodyMedium: AppTextStyles.bodyText, // Roboto, 16, Normal
          labelSmall: AppTextStyles.caption, // Roboto, 14, Light
          labelLarge:
              AppTextStyles.buttonText, // Roboto, 16, Medium (for buttons)
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle: AppTextStyles.headline1.copyWith(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacingValues.buttonPadding),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            textStyle: AppTextStyles.buttonText,
            padding: const EdgeInsets.all(AppSpacingValues.buttonPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: AppDecorations.inputDecoration,
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(AppSpacingValues.mediumMargin),
        ),
        useMaterial3: true,
      ),
    );
  }
}
