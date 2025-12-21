import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/colors.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.tertiary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      backgroundColor: AppColors.primary,
      title: null,
      actions: [
        TextButton(
          onPressed: () => Get.offNamed(AppConstants.homeRoute),
          style: TextButton.styleFrom(foregroundColor: AppColors.tertiary),
          child: Text(
            context.tr('continue_as_guest'),
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
