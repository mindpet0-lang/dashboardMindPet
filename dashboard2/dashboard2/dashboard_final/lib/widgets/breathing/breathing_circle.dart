import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BreathingCircle extends StatefulWidget {

  const BreathingCircle({
    super.key,
  });

  @override
  State<BreathingCircle> createState() =>
      _BreathingCircleState();
}

class _BreathingCircleState
    extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  bool isRunning = false;

  String text = "Inhala";

  Timer? timer;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
      lowerBound: 0.7,
      upperBound: 1.0,
    );

    controller.addStatusListener((status) {

      if (status ==
          AnimationStatus.completed) {

        setState(() {

          text = "Exhala";
        });

        controller.reverse();

      } else if (status ==
          AnimationStatus.dismissed) {

        setState(() {

          text = "Finalizado";
          isRunning = false;
        });
      }
    });
  }

  void toggleAnimation() {

    if (isRunning) {

      controller.stop();

      setState(() {

        isRunning = false;
      });

    } else {

      setState(() {

        text = "Inhala";
        isRunning = true;
      });

      controller.forward(
        from: 0.7,
      );
    }
  }

  @override
  void dispose() {

    controller.dispose();

    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: toggleAnimation,

      child: AnimatedBuilder(

        animation: controller,

        builder: (_, child) {

          return Transform.scale(

            scale: controller.value,

            child: Container(

              width: 240,
              height: 240,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                gradient: LinearGradient(

                  colors: [

                    AppColors.primary,

                    AppColors.secondary,
                  ],
                ),

                boxShadow: [

                  BoxShadow(

                    color: AppColors.primary
                        .withOpacity(0.4),

                    blurRadius: 30,

                    spreadRadius: 8,
                  ),
                ],
              ),

              child: Center(

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Icon(

                      Icons.air,

                      color: Colors.white,

                      size: 50,
                    ),

                    const SizedBox(height: 16),

                    Text(

                      text,

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 28,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      isRunning
                          ? "Toca para pausar"
                          : "Toca para iniciar",

                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}