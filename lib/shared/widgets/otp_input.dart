import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/constants/colors.dart';

class OTPInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  final int length;

  const OTPInput({
    super.key,
    required this.controller,
    this.onCompleted,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      controller: controller,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 56,
        fieldWidth: 56,
        activeFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        inactiveFillColor: Colors.transparent,
        activeColor: AppColors.tertiary,
        selectedColor: AppColors.tertiary,
        inactiveColor: AppColors.tertiary,
      ),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: onCompleted != null
          ? (value) {
              onCompleted!(value);
            }
          : null,
      onChanged: (value) {},
    );
  }
}
