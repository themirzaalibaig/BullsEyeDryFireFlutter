import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  int selectedTab = 0;
  final List<String> tabs = [
    'template_metrics',
    'session_metrics',
    'accuracy_metrics',
    'overall_metrics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        titleSpacing: 20,
        title: Text(
          context.tr('metrics'),
          style: const TextStyle(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.1,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs Bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: const Border(
                  bottom: BorderSide(color: AppColors.tertiary, width: 1.1),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
                top: 6,
                bottom: 4,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(tabs.length, (i) {
                    return _buildTab(
                      context,
                      label: context.tr(tabs[i]),
                      isSelected: selectedTab == i,
                      onTap: () {
                        setState(() {
                          selectedTab = i;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            // Filters Row
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _FilterOption(
                      title: context.tr('show_metrics_from'),
                      value: context.tr('last_90_days'),
                      onPressed: () {
                        // TODO: Show date picker
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    color: AppColors.tertiary.withOpacity(0.18),
                  ),
                  Expanded(
                    child: _FilterOption(
                      title: context.tr('sort_by'),
                      value: context.tr('last_used'),
                      onPressed: () {
                        // TODO: Show sort options
                      },
                    ),
                  ),
                ],
              ),
            ),
            // (No metrics cards and no empty state per screenshot)
            const Expanded(child: SizedBox()), // Spacer to push bottom nav up
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          width: 90,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.secondary : AppColors.tertiary,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.tertiary,
              fontWeight: FontWeight.normal,
              fontSize: 13.3,
              height: 1.24,
              letterSpacing: 0.08,
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;

  const _FilterOption({
    required this.title,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 19,
              color: AppColors.tertiary,
            ),
          ],
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.8,
              color: AppColors.tertiary,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              height: 1.25,
              letterSpacing: 0.07,
            ),
          ),
        ),
      ],
    );
  }
}
