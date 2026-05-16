import 'dart:developer';

import 'package:budgetro/core/extensions/build_context_extensions.dart';
import 'package:budgetro/core/theme/app_text_styles.dart';
import 'package:budgetro/core/utils/validator_utility.dart';
import 'package:budgetro/features/auth/presentation/widgets/auth_password_text_field.dart';
import 'package:budgetro/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return ;

    log(
      '${_firstNameController.text} '
      '${_lastNameController.text} '
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
                Text(context.l10n.signUpPage, style: AppTextStyles.signUp),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // First Name Text Field
                      AuthTextField(
                        controller: _firstNameController,
                        labelText: context.l10n.firstName,
                        hintText: context.l10n.firstNameHint,
                        prefixIcon: Icons.person,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        validator: (value) => ValidatorUtility.validateName(
                          value,
                          context.l10n.firstName,
                          context,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Last Name Text Field
                      AuthTextField(
                        controller: _lastNameController,
                        labelText: context.l10n.lastName,
                        hintText: context.l10n.lastNameHint,
                        prefixIcon: Icons.person_add,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        validator: (value) => ValidatorUtility.validateName(
                          value,
                          context.l10n.lastName,
                          context,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email Text Field
                      AuthTextField(
                        controller: _emailController,
                        labelText: context.l10n.email,
                        hintText: context.l10n.emailHint,
                        prefixIcon: Icons.alternate_email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            ValidatorUtility.validateEmail(value, context),
                      ),
                      const SizedBox(height: 20),

                      // Password Text Field
                      AuthPasswordTextField(
                        controller: _passwordController,
                        labelText: context.l10n.password,
                        hintText: context.l10n.passwordHint,
                        prefixIcon: Icons.password,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleSignUp(),
                        validator: (value) =>
                            ValidatorUtility.validatePassword(value, context),
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
