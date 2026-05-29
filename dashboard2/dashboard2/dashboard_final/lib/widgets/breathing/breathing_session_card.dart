import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BreathingSessionCard
    extends StatelessWidget {

  const BreathingSessionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(24),

        gradient: LinearGradient(

          colors: [

            AppColors.primary
                .withOpacity(0.18),

            AppColors.secondary
                .withOpacity(0.12),
          ],
        ),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets.all(16),

            decoration: BoxDecoration(

              color: AppColors.primary
                  .withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Icon(

              Icons.air,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(width: 18),

          const Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  "Sesión Activa",

                  style: TextStyle(

                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Respira profundo y relaja tu mente.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}