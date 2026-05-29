class EmotionModel {

  final int id;
  final String mood;
  final double stress;

  EmotionModel({
    required this.id,
    required this.mood,
    required this.stress,
  });

  factory EmotionModel.fromJson(
      Map<String, dynamic> json) {

    return EmotionModel(
      id: json['id'],
      mood: json['mood'],
      stress: json['stress'],
    );
  }
}