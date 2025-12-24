import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/home_controller.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final currentTab = controller.currentTab.value;
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentTab.index,
          onTap: (index) => controller.changeTab(HomeTab.values[index]),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.secondary,
          unselectedItemColor: AppColors.tertiary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: context.tr('feed'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.directions_run),
              label: context.tr('compete'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.gps_fixed),
              label: context.tr('train'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: context.tr('metrics'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.tr('profile'),
            ),
          ],
        ),
      );
    });
  }
}
