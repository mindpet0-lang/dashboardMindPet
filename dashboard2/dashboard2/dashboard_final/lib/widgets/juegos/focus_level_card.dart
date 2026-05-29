import 'package:flutter/material.dart';

class FocusLevelCard
    extends StatelessWidget {

  const FocusLevelCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(22),

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

            "Nivel de concentración",

            style: TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          Center(

            child: Stack(

              alignment:
                  Alignment.center,

              children: [

                SizedBox(

                  width: 150,
                  height: 150,

                  child:
                      CircularProgressIndicator(

                    value: 0.82,

                    strokeWidth: 12,

                    backgroundColor:
                        Colors.grey
                            .withOpacity(
                      0.2,
                    ),

                    valueColor:
                        const AlwaysStoppedAnimation(
                      Color(
                        0xFF8B5CF6,
                      ),
                    ),
                  ),
                ),

                const Column(

                  children: [

                    Text(

                      "82%",

                      style: TextStyle(

                        fontSize: 32,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Focus",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}