import '../models/chatbot_model.dart';
import '../services/chatbot_service.dart';

class ChatbotRepository {
  final ChatbotService _chatbotService = ChatbotService();

  // 📊 Solo lectura del historial de PostgreSQL
  Future<List<ChatbotModel>> getHistorialMensajes() async {
    return await _chatbotService.fetchMensajes();
  }
}