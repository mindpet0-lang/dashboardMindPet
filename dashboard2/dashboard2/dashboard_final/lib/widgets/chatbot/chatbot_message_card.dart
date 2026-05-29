import 'package:flutter/material.dart';

class ChatbotMessageCard
    extends StatelessWidget {

  const ChatbotMessageCard({
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

      child: const Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            "Última conversación",

            style: TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          SizedBox(height: 20),

          Align(

            alignment:
                Alignment.centerRight,

            child: _UserBubble(),
          ),

          SizedBox(height: 14),

          Align(

            alignment:
                Alignment.centerLeft,

            child: _AiBubble(),
          ),
        ],
      ),
    );
  }
}

class _UserBubble
    extends StatelessWidget {

  const _UserBubble();

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color:
            const Color(0xFF8B5CF6),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: const Text(

        "Hoy tuve mucha ansiedad.",

        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AiBubble
    extends StatelessWidget {

  const _AiBubble();

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color:
            const Color(0xFF06B6D4)
                .withOpacity(0.15),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: const Text(

        "Respira profundo 💜 Estoy aquí para ayudarte.",

        style: TextStyle(
          fontWeight:
              FontWeight.w500,
        ),
      ),
    );
  }
}