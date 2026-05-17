import 'package:budgetro/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthPasswordTextField extends StatefulWidget {
  const AuthPasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.textInputAction = TextInputAction.none,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  @override
  State<AuthPasswordTextField> createState() => _AuthPasswordTextFieldState();
}

class _AuthPasswordTextFieldState extends State<AuthPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        border: AppTheme.outlineInputBorder,
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon),
        // TODO Сделать в суффиксе иконку глазика, чтобы можно было переключать видимость пароля, и добоавить поле obscureText для пароля
      ),
    );
  }
}
