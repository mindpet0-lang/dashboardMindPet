import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class GameProgress extends StatelessWidget {

  final String title;
  final double progress;
  final int level;
  final IconData icon;

  const GameProgress({
    super.key,
    required this.title,
    required this.progress,
    required this.level,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(

          colors: [

            AppColors.primary.withOpacity(0.18),
            AppColors.secondary.withOpacity(0.10),

          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),

      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Container(

                padding:
                    const EdgeInsets.all(12),

                decoration: BoxDecoration(

                  color: AppColors.primary
                      .withOpacity(0.15),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      title,

                      style: const TextStyle(

                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(

                      "Nivel $level",

                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ClipRRect(

            borderRadius:
                BorderRadius.circular(30),

            child: LinearProgressIndicator(

              value: progress,

              minHeight: 12,

              backgroundColor:
                  Colors.white10,

              valueColor:
                  AlwaysStoppedAnimation(
                AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(

                "${(progress * 100).toInt()}% completado",

                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(

                  color: AppColors.secondary
                      .withOpacity(0.15),

                  borderRadius:
                      BorderRadius.circular(30),
                ),

                child: Text(

                  "${((1 - progress) * 100).toInt()}% restante",

                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}