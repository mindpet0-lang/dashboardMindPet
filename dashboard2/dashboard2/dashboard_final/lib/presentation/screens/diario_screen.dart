import 'package:flutter/material.dart';

import '../../widgets/layout/app_layout.dart';

import '../../widgets/diario/diary_sumary_card.dart';
import '../../widgets/diario/recent_notes_card.dart';
import '../../widgets/diario/emotion_calendar.dart';
import '../../widgets/diario/mini_mood_chart.dart';

class DiarioScreen
    extends StatelessWidget {

  const DiarioScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context)
                .size
                .width <
            700;

    return AppLayout(

      title: "Diario emocional",

      currentIndex: 1,

      child: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

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
                  isMobile ? 1 : 1.2,

              children: const [

                DiarySummaryCard(
                  title: "Entradas al diario",
                  value: "24",
                  icon: Icons.book,
                  color:
                      Color(0xFF8B5CF6),
                ),

                DiarySummaryCard(
                  title: "Estado",
                  value: "Feliz",
                  icon:
                      Icons.favorite,
                  color:
                      Color(0xFF06B6D4),
                ),

                DiarySummaryCard(
                  title: "Racha",
                  value: "8 días",
                  icon:
                      Icons.local_fire_department,
                  color:
                      Color(0xFF10B981),
                ),

                DiarySummaryCard(
                  title: "Ansiedad",
                  value: "Baja",
                  icon:
                      Icons.spa,
                  color:
                      Color(0xFF6366F1),
                ),
              ],
            ),

            const SizedBox(height: 24),

            isMobile

                ? const Column(

                    children: [

                      MiniMoodChart(),

                      SizedBox(height: 20),

                      RecentNotesCard(),

                      SizedBox(height: 20),

                      EmotionCalendar(),
                    ],
                  )

                : Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Expanded(
                        flex: 2,
                        child:
                            MiniMoodChart(),
                      ),

                      const SizedBox(
                          width: 20),

                      Expanded(

                        child: Column(

                          children: const [

                            RecentNotesCard(),

                            SizedBox(
                                height:
                                    20),

                            EmotionCalendar(),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}