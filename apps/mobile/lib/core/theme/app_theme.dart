import 'package:flutter/material.dart';
import 'package:budgetro/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundLight
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundDark
    );
  }
}