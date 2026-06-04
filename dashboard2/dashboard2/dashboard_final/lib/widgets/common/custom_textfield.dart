import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField
    extends StatelessWidget {

  final TextEditingController
      controller;

  final String hint;

  final IconData icon;

  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      obscureText: obscureText,

      decoration: InputDecoration(

        hintText: hint,

        prefixIcon: Icon(
          icon,
          color:
              AppColors.primary,
        ),

        filled: true,

        fillColor:
            AppColors.inputColor,

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}
//hola