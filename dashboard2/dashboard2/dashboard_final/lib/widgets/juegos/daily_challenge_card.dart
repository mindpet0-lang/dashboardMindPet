import 'package:flutter/material.dart';

class DailyChallengeCard
    extends StatelessWidget {

  const DailyChallengeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(22),

      decoration: BoxDecoration(

        gradient: const LinearGradient(

          colors: [

            Color(0xFF06B6D4),
            Color(0xFF6366F1),
          ],
        ),

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: const Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Icon(
                Icons.emoji_events,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(

                "Desafío diario",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Text(

            "Completa 3 juegos de memoria para aumentar tu concentración.",

            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}