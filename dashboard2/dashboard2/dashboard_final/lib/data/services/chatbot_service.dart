import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chatbot_model.dart';

class ChatbotService {
  final String _baseUrl = 'https://backendmindpet-production.up.railway.app/api/chat/history/1';

  // 📊 Único método: Obtener los registros para la tabla
  Future<List<ChatbotModel>> fetchMensajes() async {
    try {
      print("ChatbotService: Intentando conectar a: $_baseUrl");
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> decodedData = json.decode(responseBody);
        
        return decodedData.map((item) {
          try {
            return ChatbotModel.fromJson(item);
          } catch (e) {
            print("⚠️ Error mapeando fila: $item. Detalles: $e");
            return null;
          }
        }).whereType<ChatbotModel>().toList();
      } else {
        print("❌ Error del servidor Railway: Código ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error de red en ChatbotService: $e");
      return [];
    }
  }
}