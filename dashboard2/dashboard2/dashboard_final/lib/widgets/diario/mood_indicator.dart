import 'package:flutter/material.dart';

class MoodIndicator
    extends StatelessWidget {

  final String mood;
  final double percentage;
  final Color color;
  final IconData icon;

  const MoodIndicator({
    super.key,
    required this.mood,
    required this.percentage,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color:
            Theme.of(context).cardColor,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Container(

                padding:
                    const EdgeInsets.all(
                  10,
                ),

                decoration: BoxDecoration(

                  color:
                      color.withOpacity(
                    0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),

              const Spacer(),

              Text(

                "${percentage.toInt()}%",

                style: TextStyle(
                  color: color,
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(

            mood,

            style: const TextStyle(

              fontSize: 20,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ClipRRect(

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child: LinearProgressIndicator(

              value:
                  percentage / 100,

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

          const SizedBox(height: 10),

          Text(

            "Estado emocional actual",

            style: TextStyle(

              color: Colors.grey.shade600,

              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}