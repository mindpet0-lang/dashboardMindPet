import 'package:flutter/material.dart';

class DiarySummaryCard
    extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DiarySummaryCard({
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

        borderRadius:
            BorderRadius.circular(24),

        gradient: LinearGradient(

          colors: [

            color.withOpacity(0.9),
            color.withOpacity(0.6),
          ],
        ),

        boxShadow: [

          BoxShadow(
            color:
                color.withOpacity(0.3),
            blurRadius: 15,
            offset:
                const Offset(0, 6),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}