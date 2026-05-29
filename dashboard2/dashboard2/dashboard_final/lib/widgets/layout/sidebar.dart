import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {

  final int currentIndex;

  final Function(int) onTap;

  const Sidebar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 250,

      color: const Color(0xFF111133),

      child: Column(

        children: [

          const SizedBox(height: 60),

          buildItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            index: 0,
          ),

          buildItem(
            icon: Icons.book,
            title: "Diario",
            index: 1,
          ),

          buildItem(
            icon: Icons.smart_toy,
            title: "Chat IA",
            index: 2,
          ),

          buildItem(
            icon: Icons.games,
            title: "Foro",
            index: 3,
          ),


        ],
      ),
    );
  }

  Widget buildItem({

    required IconData icon,
    required String title,
    required int index,
  }) {

    final selected =
        currentIndex == index;

    return InkWell(

      onTap: () => onTap(index),

      child: Container(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        color: selected

            ? Colors.white10

            : Colors.transparent,

        child: Row(

          children: [

            Icon(
              icon,
              color: Colors.white,
            ),

            const SizedBox(width: 16),

            Text(

              title,

              style: const TextStyle(

                color: Colors.white,

                fontSize: 18,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}