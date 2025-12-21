import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AuthSeparator extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? thickness;
  final EdgeInsetsGeometry? padding;

  const AuthSeparator({
    super.key,
    this.text = 'or',
    this.color,
    this.thickness,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = color ?? AppColors.tertiary;
    final double dividerThickness = thickness ?? 1;
    final EdgeInsetsGeometry contentPadding =
        padding ?? const EdgeInsets.symmetric(vertical: 0, horizontal: 16);

    return Row(
      children: [
        Expanded(
          child: Divider(color: dividerColor, thickness: dividerThickness),
        ),
        if (text != null && text!.isNotEmpty)
          Padding(
            padding: contentPadding,
            child: Text(text!, style: TextStyle(color: dividerColor)),
          ),
        Expanded(
          child: Divider(color: dividerColor, thickness: dividerThickness),
        ),
      ],
    );
  }
}
