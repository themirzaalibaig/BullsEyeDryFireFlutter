import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class TrainCarouselItem extends StatelessWidget {
  const TrainCarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.center_focus_strong,
        'title': 'Practice Drills',
        'description':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      },
      {
        'icon': Icons.timer,
        'title': 'Shot Timer',
        'description':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      },
      {
        'icon': Icons.network_check,
        'title': 'Practice Drills',
        'description':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Train Title
            Column(
              children: [
                Text(
                  'Train',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColors.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Features List
            ...features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    // Icon
                    Icon(
                      feature['icon'] as IconData,
                      size: 24,
                      color: AppColors.tertiary,
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Column(
                      children: [
                        Text(
                          feature['title'] as String,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 0.5,
                          width: 128,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        feature['description'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
