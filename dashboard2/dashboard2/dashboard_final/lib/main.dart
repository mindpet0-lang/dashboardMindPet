import 'package:dashboard_final/presentation/screens/foro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/dashboard_provider.dart';
import 'presentation/providers/foro_provider.dart'; // 👈 Asegúrate de que este import exista

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // 🔥 AQUÍ ESTABA EL ERROR. Faltaba registrar tu ForoProvider de forma global:
        ChangeNotifierProvider(create: (_) => ForoProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          initialRoute: "/",
          routes: {
            "/": (context) => const LoginScreen(),
            "/login": (context) => const LoginScreen(),
            "/register": (context) => const RegisterScreen(),
            "/dashboard": (context) => const DashboardScreen(),
            "/foro": (context) => const ForoScreen(),
          },
        );
      },
    );
  }
}