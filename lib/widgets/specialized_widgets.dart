import 'package:adalat/constants/frontend_components/box_decorations.dart';
import 'package:adalat/constants/frontend_components/spacing_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../constants/frontend_components/color_palette.dart';
import '../constants/frontend_components/text_styles.dart';
import '../services/firebase/users/user_handler.dart';
import '../services/network/network_service.dart';
import 'layout_widgets.dart';
import 'navigation_widgets.dart';

class ImageHandler extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const ImageHandler({
    super.key,
    this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child:
          imageUrl != null
              ? Image.network(
                imageUrl!,
                width: width,
                height: height,
                fit: fit,
                errorBuilder:
                    (context, error, stackTrace) => Icon(
                      Icons.error,
                      color: AppColors.errorColor,
                      size: width / 2,
                    ),
              )
              : Icon(
                Icons.image,
                color: AppColors.textColor.withOpacity(0.5),
                size: width / 2,
              ),
    );
  }
}

class DocumentViewer extends StatelessWidget {
  final String documentUrl;
  final String title;

  const DocumentViewer({
    super.key,
    required this.documentUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(title, style: AppTextStyles.headline2),
          SizedBox(height: AppSpacingValues.mediumMargin),
          // Placeholder for document preview (e.g., PDF viewer or image)
          ImageHandler(imageUrl: documentUrl, width: 200, height: 200),
          SizedBox(height: AppSpacingValues.mediumMargin),
          CustomButton(
            label: 'Download',
            onPressed: () {
              // Implement download logic (e.g., open URL in browser)
            },
          ),
        ],
      ),
    );
  }
}

class RoleBasedAccessWrapper extends StatelessWidget {
  final String requiredRole; // e.g., UserRoles.judge
  final Widget child;
  final Widget? fallback;

  const RoleBasedAccessWrapper({
    super.key,
    required this.requiredRole,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final userHandler = UserHandler(NetworkService());
    return FutureBuilder(
      future: userHandler.getUser(userHandler.auth.currentUser?.uid ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.state == ApiState.success) {
          final userData = snapshot.data!.data as Map<String, dynamic>;
          if (userData['role'] == requiredRole) {
            return child;
          }
        }
        return fallback ??
            Text(
              'Access Denied',
              style: AppTextStyles.bodyText.copyWith(
                color: AppColors.errorColor,
              ),
            );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onSearch;

  const SearchBar({super.key, required this.hintText, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(AppSpacingValues.mediumPadding),
      child: TextField(
        decoration: AppDecorations.inputDecoration.copyWith(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyText.copyWith(
            color: AppColors.textColor.withOpacity(0.5),
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
        ),
        style: AppTextStyles.bodyText,
        onChanged: onSearch,
      ),
    );
  }
}

class FileUploader extends StatelessWidget {
  final Function(PlatformFile) onFileSelected;

  const FileUploader({super.key, required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: CustomButton(
        label: 'Upload File',
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();
          if (result != null && result.files.isNotEmpty) {
            onFileSelected(result.files.first);
          }
        },
      ),
    );
  }
}

class AnalyticsDashboardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AnalyticsDashboardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 32),
          SizedBox(height: AppSpacingValues.smallMargin),
          Text(title, style: AppTextStyles.headline2),
          Text(value, style: AppTextStyles.bodyText),
        ],
      ),
    );
  }
}
