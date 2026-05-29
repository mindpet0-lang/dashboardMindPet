import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BreathingTipCard
    extends StatelessWidget {

  final String tip;

  const BreathingTipCard({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(24),

        color:
            AppColors.secondary
                .withOpacity(0.12),
      ),

      child: Row(

        children: [

          Icon(
            Icons.lightbulb,
            color: AppColors.primary,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(tip),
          ),
        ],
      ),
    );
  }
}