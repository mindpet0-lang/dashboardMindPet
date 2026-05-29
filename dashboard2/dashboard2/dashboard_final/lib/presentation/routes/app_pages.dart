import 'package:dashboard_final/presentation/screens/foro_screen.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/dashboard_screen.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    "/login": (context) => const LoginScreen(),

    "/register": (context) => const RegisterScreen(),

    "/dashboard": (context) => const DashboardScreen(),

    "/foro": (context) => const ForoScreen(),
  };
}
