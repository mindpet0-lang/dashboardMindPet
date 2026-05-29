import 'package:flutter/material.dart';

import '../layout/sidebar.dart';
import '../layout/topbar.dart';

import '../../presentation/screens/dashboard_screen.dart';
import '../../presentation/screens/diario_screen.dart';
import '../../presentation/screens/chatbot_screen.dart';
import '../../presentation/screens/foro_screen.dart';
import '../../presentation/screens/respiracion_screen.dart';

class AppLayout extends StatefulWidget {
  final String title;
  final int currentIndex;
  final Widget child;

  const AppLayout({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.child,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  void navigateTo(int index) {
    Navigator.popUntil(context, (route) => route.isFirst);

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DiarioScreen()),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ChatbotScreen(
            totalMensajes: "124", 
              totalSesiones: "18",
              estadoEmocional: "Calma",
              estadoIA: "Activa",
          )),
        );
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ForoScreen()),
        );
        break;

      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RespiracionScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      drawer: isMobile
          ? Drawer(
              child: Sidebar(
                currentIndex: widget.currentIndex,
                onTap: navigateTo,
              ),
            )
          : null,

      body: Row(
        children: [
          if (!isMobile)
            Sidebar(
              currentIndex: widget.currentIndex,
              onTap: navigateTo,
            ),

          Expanded(
            child: Column(
              children: [
                TopBar(
                  title: widget.title,
                  isMobile: isMobile,
                ),

                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}