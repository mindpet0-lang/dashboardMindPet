import 'package:flutter/material.dart';

class AiStatusCard
    extends StatelessWidget {

  const AiStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(24),

        gradient: const LinearGradient(

          colors: [

            Color(0xFF8B5CF6),
            Color(0xFF6366F1),
          ],
        ),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets.all(16),

            decoration: BoxDecoration(

              color:
                  Colors.white
                      .withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: const Icon(

              Icons.smart_toy,

              color: Colors.white,

              size: 40,
            ),
          ),

          const SizedBox(width: 20),

          const Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  "MindPet AI",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(

                  "Tu asistente emocional inteligente está activo.",

                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Container(

            width: 14,
            height: 14,

            decoration: const BoxDecoration(

              color: Color(0xFF10B981),

              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}