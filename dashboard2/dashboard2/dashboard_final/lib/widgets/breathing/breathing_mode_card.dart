import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BreathingModeCard
    extends StatelessWidget {

  final String title;
  final IconData icon;

  const BreathingModeCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 170,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(24),

        gradient: LinearGradient(

          colors: [

            AppColors.primary
                .withOpacity(0.18),

            AppColors.secondary
                .withOpacity(0.10),
          ],
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            size: 34,
            color: AppColors.primary,
          ),

          const SizedBox(height: 16),

          Text(

            title,

            style: const TextStyle(

              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}