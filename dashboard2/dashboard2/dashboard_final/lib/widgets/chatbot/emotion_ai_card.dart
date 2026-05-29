import 'package:flutter/material.dart';

class EmotionAiCard
    extends StatelessWidget {

  const EmotionAiCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color:
            Theme.of(context).cardColor,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(

            "Análisis emocional IA",

            style: TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          _emotionTile(
            "Calma",
            80,
            const Color(0xFF10B981),
          ),

          _emotionTile(
            "Estrés",
            30,
            const Color(0xFF06B6D4),
          ),

          _emotionTile(
            "Ansiedad",
            25,
            const Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }

  Widget _emotionTile(
    String label,
    double value,
    Color color,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Text(label),

              Text(
                "${value.toInt()}%",
              ),
            ],
          ),

          const SizedBox(height: 8),

          ClipRRect(

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child: LinearProgressIndicator(

              value: value / 100,

              minHeight: 10,

              backgroundColor:
                  color.withOpacity(
                0.15,
              ),

              valueColor:
                  AlwaysStoppedAnimation(
                color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}