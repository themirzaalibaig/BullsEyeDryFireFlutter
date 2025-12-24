import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(() {
        final currentTab = controller.currentTab.value;
        return _buildTabContent(currentTab);
      }),
      bottomNavigationBar: Obx(() {
        final currentTab = controller.currentTab.value;
        return _buildBottomNavigationBar(controller, currentTab);
      }),
    );
  }

  Widget _buildTabContent(HomeTab tab) {
    switch (tab) {
      case HomeTab.home:
        return _buildHomeTab();
      case HomeTab.training:
        return _buildTrainingTab();
      case HomeTab.profile:
        return _buildProfileTab();
      case HomeTab.settings:
        return _buildSettingsTab();
    }
  }

  Widget _buildHomeTab() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 64, color: AppColors.tertiary),
            const SizedBox(height: 16),
            Text(
              'Home',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to Bulls Eye Dry Fire',
              style: TextStyle(fontSize: 16, color: AppColors.nonary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingTab() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 64, color: AppColors.tertiary),
            const SizedBox(height: 16),
            Text(
              'Training',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Practice drills and training',
              style: TextStyle(fontSize: 16, color: AppColors.nonary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: AppColors.tertiary),
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your profile and settings',
              style: TextStyle(fontSize: 16, color: AppColors.nonary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: AppColors.tertiary),
            const SizedBox(height: 16),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'App settings and preferences',
              style: TextStyle(fontSize: 16, color: AppColors.nonary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    HomeController controller,
    HomeTab currentTab,
  ) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.tertiary,
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
          backgroundColor: AppColors.tertiary,
          selectedItemColor: AppColors.secondary,
          unselectedItemColor: AppColors.nonary,
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
              icon: const Icon(Icons.home),
              label: context.tr('home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center),
              label: context.tr('training'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.tr('profile'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: context.tr('settings'),
            ),
          ],
        ),
      ),
    );
  }
}
