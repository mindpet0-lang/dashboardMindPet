import 'package:flutter/material.dart';
import '../../data/models/chatbot_model.dart';
import '../../data/repositories/chatbot_repository.dart';

class ChatbotProvider extends ChangeNotifier {
  final ChatbotRepository _repository;
  
  List<ChatbotModel> _messages = [];
  bool _isLoading = false;

  // Al crearse el Provider, ejecuta inmediatamente la petición HTTP a Railway
  ChatbotProvider(this._repository) {
    cargarMensajesReales();
  }

  List<ChatbotModel> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> cargarMensajesReales() async {
    _isLoading = true;
    notifyListeners();

    try {
      print("ChatbotProvider: Solicitando historial de mensajes al repositorio...");
      _messages = await _repository.getHistorialMensajes();
      print("ChatbotProvider: ¡Éxito! Se cargaron ${_messages.length} mensajes en memoria.");
    } catch (e) {
      print("❌ Error cargando tabla de mensajes en Provider: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica a la interfaz para que dibuje las filas reales
    }
  }
}