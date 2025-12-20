import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'language_selector.dart';

class LanguageDropdown extends StatelessWidget {
  final Language? selectedLanguage;
  final VoidCallback onTap;

  const LanguageDropdown({
    super.key,
    required this.selectedLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.quaternary,
          border: Border.all(
            color: AppColors.tertiary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (selectedLanguage != null) ...[
              Text(
                selectedLanguage!.flagEmoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedLanguage!.nativeName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Text(
                  'English',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.nonary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
            Icon(
              Icons.chevron_right,
              color: AppColors.tertiary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

