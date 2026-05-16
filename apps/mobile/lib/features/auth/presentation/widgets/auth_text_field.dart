import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    
    });

  final TextEditingController controller;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      
    );
  }
}
