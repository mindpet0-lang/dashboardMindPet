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
      userId: json['user_id'] ?? json['userId'] ?? 1,
    );
  }

  bool get isUser => sender.toString().toUpperCase() == 'USER';
}