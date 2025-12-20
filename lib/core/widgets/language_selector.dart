import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Language {
  final String code;
  final String name;
  final String nativeName;
  final Locale locale;
  final String flagEmoji; // Country flag emoji

  Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.locale,
    required this.flagEmoji,
  });
}

class LanguageSelector extends StatelessWidget {
  final List<Language> languages;
  final Language? selectedLanguage;
  final Function(Language)? onLanguageSelected;

  const LanguageSelector({
    super.key,
    required this.languages,
    this.selectedLanguage,
    this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select Language',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ...languages.map((language) {
          final isSelected = selectedLanguage?.code == language.code;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LanguageItem(
              language: language,
              isSelected: isSelected,
              onTap: () {
                if (onLanguageSelected != null) {
                  onLanguageSelected!(language);
                }
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.quaternary,
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.senary,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.nativeName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.tertiary
                          : AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language.name,
                    style: TextStyle(fontSize: 14, color: AppColors.nonary),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.secondary, size: 24),
          ],
        ),
      ),
    );
  }
}
