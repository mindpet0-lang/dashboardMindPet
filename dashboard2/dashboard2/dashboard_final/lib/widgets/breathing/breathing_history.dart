import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BreathingHistory
    extends StatelessWidget {

  const BreathingHistory({
    super.key,
  });

  Widget item(
      String mode,
      String time,
      String date) {

    return Container(

      margin:
          const EdgeInsets.only(bottom: 14),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(20),

        color:
            Colors.white.withOpacity(0.05),

        border: Border.all(
          color: AppColors.primary
              .withOpacity(0.15),
        ),
      ),

      child: Row(

        children: [

          CircleAvatar(

            backgroundColor:
                AppColors.primary
                    .withOpacity(0.2),

            child: Icon(
              Icons.air,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  mode,

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(date),
              ],
            ),
          ),

          Text(

            time,

            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        item(
          "Relajación",
          "10 min",
          "Hoy",
        ),

        item(
          "Sueño",
          "8 min",
          "Ayer",
        ),

        item(
          "Ansiedad",
          "15 min",
          "Lunes",
        ),
      ],
    );
  }
}