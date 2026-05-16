import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = "Quicksand";
  
  static const TextStyle signUp = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
}