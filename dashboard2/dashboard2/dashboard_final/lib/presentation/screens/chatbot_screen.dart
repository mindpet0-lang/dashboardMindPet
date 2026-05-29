import 'package:flutter/material.dart';

import '../../widgets/layout/app_layout.dart';

import '../../widgets/chatbot/ai_status_card.dart';
import '../../widgets/chatbot/chatbot_stats_card.dart';
import '../../widgets/chatbot/quick_action_card.dart';
import '../../widgets/chatbot/emotion_ai_card.dart';
import '../../widgets/chatbot/chatbot_message_card.dart';

class ChatbotScreen
    extends StatelessWidget {
      final String totalMensajes;
  final String totalSesiones;
  final String estadoEmocional;
  final String estadoIA;  
  
  const ChatbotScreen({
    super.key,
    required this.totalMensajes,
    required this.totalSesiones,
    required this.estadoEmocional,
    required this.estadoIA,
  });

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context)
                .size
                .width <
            800;

    return AppLayout(

      title: "MindPet AI",

      currentIndex: 2,

      child: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            const AiStatusCard(),

            const SizedBox(height: 24),

            GridView.count(

              crossAxisCount:
                  isMobile ? 2 : 4,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio:
                  isMobile ? 1 : 1.1,

              children: [

                ChatbotStatsCard(
                  title: "Mensajes",
                  value: totalMensajes,
                  icon: Icons.chat,
                  color:
                      Color(0xFF8B5CF6),
                ),

                ChatbotStatsCard(
                  title: "Sesiones",
                  value: "18",
                  icon: Icons.psychology,
                  color:
                      Color(0xFF06B6D4),
                ),

                ChatbotStatsCard(
                  title: "Estado",
                  value: "Calma",
                  icon:
                      Icons.favorite,
                  color:
                      Color(0xFF10B981),
                ),

                ChatbotStatsCard(
                  title: "IA",
                  value: "Activa",
                  icon:
                      Icons.smart_toy,
                  color:
                      Color(0xFF6366F1),
                ),
              ],
            ),

            const SizedBox(height: 24),

            GridView.count(

              crossAxisCount:
                  isMobile ? 2 : 4,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio: 1.3,

              children: const [

                QuickActionCard(
                  title:
                      "Hablar con IA",
                  icon:
                      Icons.chat_bubble,
                  color:
                      Color(0xFF8B5CF6),
                ),

                QuickActionCard(
                  title:
                      "Respiración",
                  icon: Icons.air,
                  color:
                      Color(0xFF06B6D4),
                ),

                QuickActionCard(
                  title:
                      "Meditación",
                  icon:
                      Icons.spa,
                  color:
                      Color(0xFF10B981),
                ),

                QuickActionCard(
                  title:
                      "Estado emocional",
                  icon:
                      Icons.favorite,
                  color:
                      Color(0xFF6366F1),
                ),
              ],
            ),

            const SizedBox(height: 24),

            isMobile

                ? const Column(

                    children: [

                      EmotionAiCard(),

                      SizedBox(height: 20),

                      ChatbotMessageCard(),
                    ],
                  )

                : const Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Expanded(
                        child:
                            EmotionAiCard(),
                      ),

                      SizedBox(width: 20),

                      Expanded(
                        child:
                            ChatbotMessageCard(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}