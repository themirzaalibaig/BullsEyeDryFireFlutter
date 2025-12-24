import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'feed_page.dart';
import 'compete_page.dart';
import 'train_page.dart';
import 'metrics_page.dart';
import 'profile_page.dart';

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
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Widget _buildTabContent(HomeTab tab) {
    switch (tab) {
      case HomeTab.feed:
        return const FeedPage();
      case HomeTab.compete:
        return const CompetePage();
      case HomeTab.train:
        return const TrainPage();
      case HomeTab.metrics:
        return const MetricsPage();
      case HomeTab.profile:
        return const ProfilePage();
    }
  }
}
