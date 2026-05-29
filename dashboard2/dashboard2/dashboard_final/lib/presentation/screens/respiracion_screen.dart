import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/breathing_provider.dart';

import '../../../widgets/layout/app_layout.dart';

import '../../../widgets/breathing/breathing_circle.dart';
import '../../../widgets/breathing/breathing_session_card.dart';
import '../../../widgets/breathing/breathing_stats.dart';
import '../../../widgets/breathing/breathing_mode_card.dart';
import '../../../widgets/breathing/breathing_tip_card.dart';
import '../../../widgets/breathing/breathing_history.dart';

class RespiracionScreen
    extends StatefulWidget {

  const RespiracionScreen({
    super.key,
  });

  @override
  State<RespiracionScreen>
      createState() =>
          _RespiracionScreenState();
}

class _RespiracionScreenState
    extends State<RespiracionScreen> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      Provider.of<BreathingProvider>(
        context,
        listen: false,
      ).startBreathing();
    });
  }

  @override
  Widget build(BuildContext context) {

    return AppLayout(

      title: "Respiración",
      currentIndex: 4,

      child: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const BreathingSessionCard(),

            const SizedBox(height: 30),

            const Center(
              child: BreathingCircle(),
            ),

            const SizedBox(height: 40),

            const Text(

              "Tus estadísticas",

              style: TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const BreathingStats(),

            const SizedBox(height: 40),

            const Text(

              "Modos",

              style: TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(

              spacing: 16,
              runSpacing: 16,

              children: const [

                BreathingModeCard(
                  title: "Relajación",
                  icon: Icons.spa,
                ),

                BreathingModeCard(
                  title: "Sueño",
                  icon: Icons.nightlight,
                ),

                BreathingModeCard(
                  title: "Ansiedad",
                  icon: Icons.favorite,
                ),

                BreathingModeCard(
                  title: "Focus",
                  icon: Icons.psychology,
                ),
              ],
            ),

            const SizedBox(height: 40),

            const BreathingTipCard(
              tip:
                  "Respira lento durante 4 segundos y exhala durante 6 segundos.",
            ),

            const SizedBox(height: 40),

            const Text(

              "Historial",

              style: TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const BreathingHistory(),
          ],
        ),
      ),
    );
  }
}