import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BreathingStats extends StatelessWidget {
  const BreathingStats({super.key});

  Widget statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),

          color: Colors.white.withOpacity(0.05),

          border: Border.all(color: AppColors.primary.withOpacity(0.15)),
        ),

        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 34),

            const SizedBox(height: 14),

            Text(
              value,

              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        statCard("Sesiones", "18", Icons.favorite),

        const SizedBox(width: 18),

        statCard("Minutos", "124", Icons.timer),

        const SizedBox(width: 18),

        statCard("Racha", "7 días", Icons.local_fire_department),
      ],
    );
  }
}
