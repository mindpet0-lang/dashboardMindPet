import 'package:flutter/material.dart';

class GameCard
    extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const GameCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        gradient: LinearGradient(

          colors: [

            color.withOpacity(0.9),
            color.withOpacity(0.7),
          ],
        ),

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(

            padding:
                const EdgeInsets.all(14),

            decoration: BoxDecoration(

              color:
                  Colors.white
                      .withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),

          const Spacer(),

          Text(

            title,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(

            subtitle,

            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}