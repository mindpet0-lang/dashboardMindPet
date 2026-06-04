import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CustomButton
    extends StatelessWidget {

  final String text;

  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      onPressed: onPressed,

      style:
          ElevatedButton.styleFrom(

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),
      ),

      child: Text(
        text,
        style:
            AppTextStyles.buttonText,
      ),
    );
  }
}
//hola