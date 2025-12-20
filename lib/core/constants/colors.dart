import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFCE1B); // Yellow
  static const Color secondary = Color(0xFFEB1C23); // Red
  static const Color tertiary = Color(0xFF000000); // Black
  static const Color quaternary = Color(0xFFFFFFFF); // White
  static const Color quinary = Color(0xFFF5F5F5); // Light Gray
  static const Color senary = Color(0xFFE5E5E5); // Medium Gray
  static const Color septenary = Color(0xFFD3D3D3); // Dark Gray
  static const Color octonary = Color(0xFFA9A9A9); // Gray
  static const Color nonary = Color(0xFF808080); // Gray
  static const Color denary = Color(0xFF595959); // Gray

  // Additional color constants for better organization
  static const Map<String, Color> colors = {
    'primary': primary,
    'secondary': secondary,
    'tertiary': tertiary,
    'quaternary': quaternary,
    'quinary': quinary,
    'senary': senary,
    'septenary': septenary,
    'octonary': octonary,
    'nonary': nonary,
    'denary': denary,
  };
}

