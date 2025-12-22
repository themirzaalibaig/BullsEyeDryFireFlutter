import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../core/constants/colors.dart';

class AuthPhoneInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? phoneController;
  final TextEditingController? countryCodeController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final String? initialCountryCode;

  const AuthPhoneInput({
    super.key,
    this.label,
    this.hint,
    this.phoneController,
    this.countryCodeController,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.initialCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.tertiary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            // Country Code Picker
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(color: AppColors.tertiary, width: 1),
                ),
              ),
              child: CountryCodePicker(
                onChanged: (country) {
                  if (countryCodeController != null) {
                    countryCodeController!.text = country.dialCode ?? '+1';
                  }
                },
                initialSelection: initialCountryCode ?? 'US',
                favorite: const ['+1', 'US'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.tertiary,
                ),
                dialogTextStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.tertiary,
                ),
                flagWidth: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Phone Number Input
            Expanded(
              child: TextFormField(
                controller: phoneController,
                validator: validator,
                keyboardType: TextInputType.phone,
                onChanged: onChanged,
                focusNode: focusNode,
                textInputAction: textInputAction,
                showCursor: true,
                cursorColor: AppColors.tertiary,
                onFieldSubmitted: onSubmitted,
                style: const TextStyle(fontSize: 16, color: AppColors.tertiary),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: AppColors.nonary.withOpacity(0.6),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tertiary, width: 1),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tertiary, width: 1),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tertiary, width: 2),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.secondary,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.secondary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
