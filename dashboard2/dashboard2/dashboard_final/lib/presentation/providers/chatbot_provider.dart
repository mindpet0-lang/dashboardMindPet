import 'package:flutter/material.dart';

import '../../data/models/chatbot_model.dart';
import '../../data/repositories/chatbot_repository.dart';

class ChatbotProvider extends ChangeNotifier {
  final ChatbotRepository _repository;

  ChatbotProvider(this._repository);

  List<ChatbotModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ChatbotModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> cargarMensajesReales() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _messages = await _repository.getHistorialMensajes();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
//hola