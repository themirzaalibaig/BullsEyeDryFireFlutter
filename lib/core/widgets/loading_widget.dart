import 'package:flutter/material.dart';
import '../constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? size;

  const LoadingWidget({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 24,
      height: size ?? 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primary,
        ),
      ),
    );
  }
}

