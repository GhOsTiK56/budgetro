import 'package:budgetro/core/theme/app_text_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up Page', style: AppTextStyles.signUp),
            const SizedBox(height: 10),

            // First Name Field
            AuthTextField(controller: _firstNameController),

            const SizedBox(height: 10),

            // Last Name Field
            AuthTextField(controller: _lastNameController),

            const SizedBox(height: 10),

            // Email Field
            AuthTextField(controller: _emailController),

            const SizedBox(height: 10),

            // Password Field
            AuthTextField(controller: _passwordController),
          ],
        ),
      ),
    );
  }
}
