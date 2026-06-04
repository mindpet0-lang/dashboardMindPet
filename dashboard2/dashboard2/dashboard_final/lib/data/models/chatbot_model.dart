class ChatbotModel {
  final int id;
  final String content;
  final String sender; 
  final String timestamp;
  final int userId;

  ChatbotModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.userId,
  });

  factory ChatbotModel.fromJson(Map<String, dynamic> json) {
    return ChatbotModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? json['message'] ?? '', 
      sender: json['sender'] ?? 'USER',
      timestamp: json['timestamp'] ?? '',
      // 🔑 Mapeo seguro para bases de datos relacionales (user_id)
      userId: json['user_id'] ?? json['userId'] ?? 0,
    );
  }

  bool get isUser => sender.toString().toUpperCase() == 'USER';
}