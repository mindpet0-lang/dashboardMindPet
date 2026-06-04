import 'package:flutter/material.dart';

import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode _themeMode =
      ThemeMode.light;

  ThemeMode get themeMode =>
      _themeMode;

  ThemeData get lightTheme =>
      AppTheme.lightTheme;

  ThemeData get darkTheme =>
      AppTheme.darkTheme;

  void toggleTheme() {

    if (_themeMode ==
        ThemeMode.light) {

      _themeMode =
          ThemeMode.dark;

    } else {

      _themeMode =
          ThemeMode.light;
    }

    notifyListeners();
  }
}
//hola