import 'dart:developer';

import 'package:budgetro/core/extensions/build_context_extensions.dart';
import 'package:budgetro/core/routing/rout_names.dart';
import 'package:budgetro/core/theme/app_text_styles.dart';
import 'package:budgetro/core/utils/validator_utility.dart';
import 'package:budgetro/features/auth/presentation/widgets/auth_password_text_field.dart';
import 'package:budgetro/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:budgetro/features/auth/presentation/widgets/action_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO Добавить смену Email на телефон
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    log(
      '${_emailController.text} '
      '${_passwordController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(context.l10n.loginPage, style: AppTextStyles.signUp),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Text Field
                      AuthTextField(
                        controller: _emailController,
                        labelText: context.l10n.email,
                        hintText: context.l10n.emailHint,
                        prefixIcon: Icons.alternate_email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) => ValidatorUtility.validateEmail(
                          value,
                          context.l10n.email,
                          context,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Text Field
                      AuthPasswordTextField(
                        controller: _passwordController,
                        labelText: context.l10n.password,
                        hintText: context.l10n.passwordHint,
                        prefixIcon: Icons.password,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleLogin(),
                        validator: (value) => ValidatorUtility.validatePassword(
                          value,
                          context.l10n.password,
                          context,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Button & To Home Page
                      ActionButton(
                        text: context.l10n.login,
                        onPressed: _handleLogin,
                      ),
                      const SizedBox(height: 20),

                      // Button to Sign Up
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: AppTextStyles.textSpanStyle,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: AppTextStyles.textSpanStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(Routes.signUp);
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
