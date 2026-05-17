import 'package:budgetro/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
        minimumSize: Size(double.infinity, 56)
      ),
      child: Text(text, style: AppTextStyles.buttonTextStyle,),
    );
  }
}
