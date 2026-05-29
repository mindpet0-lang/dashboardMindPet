import 'package:flutter/material.dart';

import '../../widgets/layout/app_layout.dart';

import '../../widgets/juegos/game_card.dart';
import '../../widgets/juegos/game_stats_card.dart';
import '../../widgets/juegos/focus_level_card.dart';
import '../../widgets/juegos/daily_challenge_card.dart';
import '../../widgets/juegos/memory_score_card.dart';

class JuegosScreen
    extends StatelessWidget {

  const JuegosScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context)
                .size
                .width <
            800;

    return AppLayout(

      title: "Juegos mentales",

      currentIndex: 3,

      child: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            GridView.count(

              crossAxisCount:
                  isMobile ? 2 : 4,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio:
                  isMobile ? 1 : 1.1,

              children: const [

                GameStatsCard(
                  title: "Partidas",
                  value: "48",
                  icon: Icons.games,
                  color:
                      Color(0xFF8B5CF6),
                ),

                GameStatsCard(
                  title: "Racha",
                  value: "12",
                  icon:
                      Icons.local_fire_department,
                  color:
                      Color(0xFF10B981),
                ),

                GameStatsCard(
                  title: "Tiempo",
                  value: "3h",
                  icon: Icons.timer,
                  color:
                      Color(0xFF06B6D4),
                ),

                GameStatsCard(
                  title: "Nivel",
                  value: "Pro",
                  icon:
                      Icons.emoji_events,
                  color:
                      Color(0xFF6366F1),
                ),
              ],
            ),

            const SizedBox(height: 24),

            GridView.count(

              crossAxisCount:
                  isMobile ? 1 : 3,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio:
                  isMobile ? 1.5 : 1.1,

              children: const [

                GameCard(
                  title: "Memoria",
                  subtitle:
                      "Entrena tu mente",
                  icon:
                      Icons.psychology,
                  color:
                      Color(0xFF8B5CF6),
                ),

                GameCard(
                  title: "Concentración",
                  subtitle:
                      "Mejora tu enfoque",
                  icon:
                      Icons.visibility,
                  color:
                      Color(0xFF06B6D4),
                ),

                GameCard(
                  title: "Relajación",
                  subtitle:
                      "Reduce estrés",
                  icon: Icons.spa,
                  color:
                      Color(0xFF10B981),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const DailyChallengeCard(),

            const SizedBox(height: 24),

            isMobile

                ? const Column(

                    children: [

                      FocusLevelCard(),

                      SizedBox(height: 20),

                      MemoryScoreCard(),
                    ],
                  )

                : const Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Expanded(
                        child:
                            FocusLevelCard(),
                      ),

                      SizedBox(width: 20),

                      Expanded(
                        child:
                            MemoryScoreCard(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}