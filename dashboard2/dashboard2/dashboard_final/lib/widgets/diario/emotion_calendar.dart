import 'package:flutter/material.dart';

class EmotionCalendar
    extends StatelessWidget {

  const EmotionCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final moods = [

      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.green,
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
            "Calendario emocional",
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(

            spacing: 12,
            runSpacing: 12,

            children: List.generate(

              30,

              (index) => Container(

                width: 42,
                height: 42,

                decoration: BoxDecoration(

                  color: moods[
                      index %
                          moods.length],

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: Center(

                  child: Text(

                    "${index + 1}",

                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//hola