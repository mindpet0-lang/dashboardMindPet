class ChatbotService {

  Future<String> sendMessage(
      String text,
      ) async {

    await Future.delayed(
      const Duration(seconds: 1),
    );

    return "Estoy aquí para ayudarte 💜";
  }
}