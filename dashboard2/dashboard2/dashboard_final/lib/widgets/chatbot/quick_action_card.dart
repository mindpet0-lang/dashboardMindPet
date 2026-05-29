import 'package:flutter/material.dart';

class QuickActionCard
    extends StatelessWidget {

  final String title;
  final IconData icon;
  final Color color;

  const QuickActionCard({
    super.key,
    required this.title,
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
            BorderRadius.circular(22),
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Container(

            padding:
                const EdgeInsets.all(14),

            decoration: BoxDecoration(

              color:
                  color.withOpacity(
                0.15,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 14),

          Text(

            title,

            textAlign:
                TextAlign.center,

            style: const TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}