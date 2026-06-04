import 'package:flutter/material.dart';
import 'app_routes.dart'; 
import '../../presentation/screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../../presentation/screens/dashboard_screen.dart';
import '../screens/diario_screen.dart';       
import '../screens/chatbot_screen.dart';     
import '../screens/foro_screen.dart';


class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.register: (context) => const RegisterScreen(),
    AppRoutes.dashboard: (context) => const DashboardScreen(),
    AppRoutes.diario: (context) => const DiarioScreen(),           
    AppRoutes.chatbot: (context) => const ChatbotScreen(),         
    AppRoutes.foro: (context) => const ForoScreen(),
  };
}
//hola