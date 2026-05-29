import 'package:flutter/material.dart';

import '../../presentation/routes/app_routes.dart';

class MobileNavbar extends StatelessWidget {
  final int currentIndex;

  const MobileNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7C4DFF),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.dashboard);
            break;

          case 1:
            Navigator.pushNamed(context, AppRoutes.diario);
            break;

          case 2:
            Navigator.pushNamed(context, AppRoutes.chatbot);
            break;

          case 3:
            Navigator.pushNamed(context, AppRoutes.juegos);
            break;

          case 4:
            Navigator.pushNamed(context, AppRoutes.respiracion);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Diario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_toy),
          label: 'IA',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.games),
          label: 'Juegos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.air),
          label: 'Respirar',
        ),
      ],
    );
  }
}