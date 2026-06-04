import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/chatbot_model.dart';

class ChatbotService {
  // 🌍 URL Base sin el ID fijo al final
  static const String _baseUrl =
      'https://backendmindpet-production.up.railway.app/api/chat/history';

  /// Realiza peticiones simultáneas para los usuarios especificados y unifica el historial
  Future<List<ChatbotModel>> fetchMensajes() async {
    // 👥 Define aquí los IDs de los usuarios que deseas mapear en tu panel
    final List<int> idsDeUsuarios = [1, 2, 3, 4, 5]; 
    final List<ChatbotModel> todosLosMensajes = [];

    try {
      // Disparamos todas las peticiones HTTP en paralelo
      final futures = idsDeUsuarios.map((id) async {
        final urlFinal = '$_baseUrl/$id';
        debugPrint('ChatbotService: Consultando auditoría del usuario $id en $urlFinal');

        try {
          final response = await http
              .get(Uri.parse(urlFinal))
              .timeout(const Duration(seconds: 12));

          if (response.statusCode == 200) {
            final decoded = json.decode(utf8.decode(response.bodyBytes));
            if (decoded is List) {
              return decoded
                  .whereType<Map<String, dynamic>>()
                  .map(ChatbotModel.fromJson)
                  .toList();
            }
          }
        } catch (e) {
          debugPrint('Aviso: El usuario $id no pudo ser cargado o no tiene mensajes: $e');
        }
        return <ChatbotModel>[]; // Retorna lista vacía en caso de error individual
      });

      // Esperamos la resolución de todas las promesas externas
      final resultados = await Future.wait(futures);

      // Agrupamos el set de datos en la lista maestra
      for (final listaMensajes in resultados) {
        todosLosMensajes.addAll(listaMensajes);
      }

      // Ordenamos globalmente por ID de mensaje de forma ascendente
      todosLosMensajes.sort((a, b) => a.id.compareTo(b.id));

      return todosLosMensajes;

    } catch (e) {
      throw Exception('Error al consolidar el historial unificado del chatbot: $e');
    }
  }
}