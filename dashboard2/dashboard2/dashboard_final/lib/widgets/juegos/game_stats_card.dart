import 'package:flutter/material.dart';

class GameStatsCard
    extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const GameStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color:
            Theme.of(context).cardColor,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(

            padding:
                const EdgeInsets.all(12),

            decoration: BoxDecoration(

              color:
                  color.withOpacity(
                0.15,
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const Spacer(),

          Text(

            value,

            style: const TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(title),
        ],
      ),
    );
  }
}