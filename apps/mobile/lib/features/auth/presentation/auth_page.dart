import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/routing/rout_names.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auth Page'),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.home);
              },
              child: const Text('To Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
