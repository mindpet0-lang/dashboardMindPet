import 'package:flutter/material.dart';

class RecentNotesCard
    extends StatelessWidget {

  const RecentNotesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final notes = [

      "Hoy me sentí más tranquila 🌿",

      "La respiración me ayudó bastante 💜",

      "Tuve ansiedad en la tarde",

      "Dormí mejor que ayer ✨",
    ];

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Theme.of(context)
            .cardColor,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "Entradas recientes",
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ...notes.map(

            (note) => Padding(

              padding:
                  const EdgeInsets.only(
                bottom: 14,
              ),

              child: Row(

                children: [

                  const CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        Color(0xFF8B5CF6),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      note,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}