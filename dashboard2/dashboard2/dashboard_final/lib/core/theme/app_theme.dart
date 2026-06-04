import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(

    useMaterial3: true,

    brightness:
        Brightness.light,

    scaffoldBackgroundColor:
        AppColors.lightBackground,

    cardColor:
        AppColors.lightCard,

    colorScheme:
        const ColorScheme.light(

      primary:
          AppColors.primary,

      secondary:
          AppColors.secondary,
    ),
  );

  static ThemeData darkTheme =
      ThemeData(

    useMaterial3: true,

    brightness:
        Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.darkBackground,

    cardColor:
        AppColors.darkCard,

    colorScheme:
        const ColorScheme.dark(

      primary:
          AppColors.primary,

      secondary:
          AppColors.secondary,
    ),
  );
}
//hola