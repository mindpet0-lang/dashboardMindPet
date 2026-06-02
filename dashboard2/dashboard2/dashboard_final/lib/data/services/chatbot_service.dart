import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/chatbot_model.dart';

class ChatbotService {
  static const String _baseUrl =
      'https://backendmindpet-production.up.railway.app/api/chat/history/1';

  Future<List<ChatbotModel>> fetchMensajes() async {
    try {
      debugPrint('ChatbotService: conectando a $_baseUrl');

      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw Exception('Error del servidor: ${response.statusCode}');
      }

      final decoded = json.decode(utf8.decode(response.bodyBytes));
      if (decoded is! List) return const [];

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(ChatbotModel.fromJson)
          .toList();
    } catch (e) {
      throw Exception('No se pudo cargar el historial del chatbot. $e');
    }
  }
}
