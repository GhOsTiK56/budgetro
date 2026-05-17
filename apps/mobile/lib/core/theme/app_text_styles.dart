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

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static const TextStyle textSpanStyle = TextStyle(
fontFamily: fontFamily,
fontSize: 20,
fontWeight: FontWeight.normal,
color: AppColors.blackColor,
  );
}