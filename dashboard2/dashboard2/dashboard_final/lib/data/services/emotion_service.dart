import 'dart:convert';

import 'package:http/http.dart' as http;

class EmotionService {

  static const String baseUrl =
      "https://backendmindpet-production.up.railway.app/api";

  Future<void> saveEmotion({

    required String emotion,

    required String note,

    required int intensity,

  }) async {

    await http.post(

      Uri.parse("$baseUrl/emotions"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "emotion": emotion,

        "note": note,

        "intensity": intensity,

      }),
    );
  }

  Future<List<dynamic>>
      getEmotions() async {

    final response = await http.get(
      Uri.parse("$baseUrl/emotions"),
    );

    return jsonDecode(response.body);
  }
}
//hola