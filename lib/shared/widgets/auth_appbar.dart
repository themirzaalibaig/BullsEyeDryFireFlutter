import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: null,
      actions: [
        TextButton(
          onPressed: () => Get.offNamed(AppConstants.homeRoute),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          child: const Text(
            'Continue as Guest',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
