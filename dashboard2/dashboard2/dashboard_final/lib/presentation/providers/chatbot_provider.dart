import 'package:flutter/material.dart';

class ChatbotProvider
    extends ChangeNotifier {

  List<String> messages = [];

  void sendMessage(String msg) {

    messages.add(msg);

    notifyListeners();
  }
}