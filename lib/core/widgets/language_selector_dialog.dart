import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import 'app_button.dart';
import 'language_selector.dart';

class LanguageSelectorDialog extends StatefulWidget {
  final List<Language> languages;
  final Language? selectedLanguage;
  final Function(Language)? onLanguageSelected;

  const LanguageSelectorDialog({
    super.key,
    required this.languages,
    this.selectedLanguage,
    this.onLanguageSelected,
  });

  static Future<Language?> show({
    required BuildContext context,
    required List<Language> languages,
    Language? selectedLanguage,
    Function(Language)? onLanguageSelected,
  }) {
    return showDialog<Language>(
      context: context,
      barrierDismissible: true,
      builder: (context) => LanguageSelectorDialog(
        languages: languages,
        selectedLanguage: selectedLanguage,
        onLanguageSelected: onLanguageSelected,
      ),
    );
  }

  @override
  State<LanguageSelectorDialog> createState() => _LanguageSelectorDialogState();
}

class _LanguageSelectorDialogState extends State<LanguageSelectorDialog> {
  late Language? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.selectedLanguage;
  }

  void _selectLanguage(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _confirmSelection() {
    if (_selectedLanguage != null) {
      if (widget.onLanguageSelected != null) {
        widget.onLanguageSelected!(_selectedLanguage!);
      }
      Navigator.of(context).pop(_selectedLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              context.tr('select_language'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.tr('choose_language'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.nonary,
                  ),
            ),
            const SizedBox(height: 24),

            // Language list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.languages.length,
                itemBuilder: (context, index) {
                  final language = widget.languages[index];
                  final isSelected = _selectedLanguage?.code == language.code;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _LanguageItem(
                      language: language,
                      isSelected: isSelected,
                      onTap: () => _selectLanguage(language),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Confirm button
            AppButton(
              text: context.tr('confirm'),
              onPressed: _selectedLanguage != null ? _confirmSelection : null,
              isEnabled: _selectedLanguage != null,
              icon: Icons.check,
            ),
          ],
        ),
      ),
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
            // Flag emoji
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.senary,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  language.flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.nativeName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.tertiary : AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.nonary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.secondary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

