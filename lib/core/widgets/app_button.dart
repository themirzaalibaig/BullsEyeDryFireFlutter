import 'package:flutter/material.dart';
import '../constants/colors.dart';

enum AppButtonVariant { default_, primary, secondary, outline, ghost }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final AppButtonVariant variant;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final EdgeInsets? padding;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = AppButtonVariant.default_,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPress = isEnabled && !isLoading && onPressed != null;
    final ButtonStyle buttonStyle = _getButtonStyle(canPress);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: _buildButton(buttonStyle, canPress),
    );
  }

  ButtonStyle _getButtonStyle(bool canPress) {
    Color bgColor;
    Color txtColor;
    Color? borderColor;
    double? borderWidth;
    double elevation;

    switch (variant) {
      case AppButtonVariant.default_:
        bgColor = backgroundColor ?? AppColors.tertiary;
        txtColor = textColor ?? AppColors.quaternary;
        borderColor = null;
        borderWidth = null;
        elevation = canPress ? 2 : 0;
        break;
      case AppButtonVariant.primary:
        bgColor = backgroundColor ?? AppColors.primary;
        txtColor = textColor ?? AppColors.tertiary;
        borderColor = null;
        borderWidth = null;
        elevation = canPress ? 2 : 0;
        break;
      case AppButtonVariant.secondary:
        bgColor = backgroundColor ?? AppColors.secondary;
        txtColor = textColor ?? AppColors.quaternary;
        borderColor = null;
        borderWidth = null;
        elevation = canPress ? 2 : 0;
        break;
      case AppButtonVariant.outline:
        bgColor = Colors.transparent;
        txtColor = textColor ?? AppColors.tertiary;
        borderColor = canPress
            ? (backgroundColor ?? AppColors.tertiary)
            : AppColors.septenary;
        borderWidth = 1.5;
        elevation = 0;
        break;
      case AppButtonVariant.ghost:
        bgColor = Colors.transparent;
        txtColor = textColor ?? AppColors.tertiary;
        borderColor = null;
        borderWidth = null;
        elevation = 0;
        break;
    }

    // Override with custom colors if provided
    if (backgroundColor != null) bgColor = backgroundColor!;
    if (textColor != null) txtColor = textColor!;

    return ElevatedButton.styleFrom(
      backgroundColor: canPress ? bgColor : AppColors.septenary,
      foregroundColor: canPress ? txtColor : AppColors.nonary,
      disabledBackgroundColor: AppColors.septenary,
      disabledForegroundColor: AppColors.nonary,
      elevation: elevation,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        side: borderColor != null
            ? BorderSide(color: borderColor, width: borderWidth ?? 1.5)
            : BorderSide.none,
      ),
    );
  }

  Widget _buildButton(ButtonStyle buttonStyle, bool canPress) {
    if (variant == AppButtonVariant.outline ||
        variant == AppButtonVariant.ghost) {
      return OutlinedButton(
        onPressed: canPress ? onPressed : null,
        style: buttonStyle,
        child: _buildChild(canPress),
      );
    }

    return ElevatedButton(
      onPressed: canPress ? onPressed : null,
      style: buttonStyle,
      child: _buildChild(canPress),
    );
  }

  Widget _buildChild(bool canPress) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(_getLoadingColor(canPress)),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Color _getLoadingColor(bool canPress) {
    if (!canPress) return AppColors.nonary;

    switch (variant) {
      case AppButtonVariant.default_:
        return textColor ?? AppColors.quaternary;
      case AppButtonVariant.primary:
        return textColor ?? AppColors.tertiary;
      case AppButtonVariant.secondary:
        return textColor ?? AppColors.quaternary;
      case AppButtonVariant.outline:
        return textColor ?? AppColors.tertiary;
      case AppButtonVariant.ghost:
        return textColor ?? AppColors.tertiary;
    }
  }
}
