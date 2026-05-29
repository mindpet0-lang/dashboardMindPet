import 'package:flutter/material.dart';

class MemoryScoreCard
    extends StatelessWidget {

  const MemoryScoreCard({
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

            "Puntaje memoria",

            style: TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Container(

            height: 14,

            decoration: BoxDecoration(

              color:
                  Colors.grey
                      .withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: FractionallySizedBox(

              alignment:
                  Alignment.centerLeft,

              widthFactor: 0.76,

              child: Container(

                decoration: BoxDecoration(

                  gradient:
                      const LinearGradient(

                    colors: [

                      Color(
                        0xFF8B5CF6,
                      ),

                      Color(
                        0xFF10B981,
                      ),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(

            "76 puntos de memoria obtenidos",

            style: TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}