import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Repositorios e Inyecciones
import 'package:dashboard_final/data/repositories/chatbot_repository.dart';

// Proveedores globales del Estado
import 'core/theme/theme_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/dashboard_provider.dart';
import 'presentation/providers/foro_provider.dart'; 
import 'presentation/providers/chatbot_provider.dart';

// Pantallas Base del Ecosistema
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/dashboard_screen.dart'; 
import 'presentation/screens/chatbot_screen.dart'; 
import 'presentation/screens/foro_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Instancia única inyectada de forma secuencial
  final chatbotRepository = ChatbotRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ForoProvider()),
        ChangeNotifierProvider(
          create: (_) => ChatbotProvider(chatbotRepository),
        ),
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
            "/chatbot": (context) => const ChatbotScreen(),
            "/foro": (context) => const ForoScreen(),
          },
        );
      },
    );
  }
}