class BreathingModel {

  final int id;
  final String mode;
  final int duration;
  final String date;

  BreathingModel({
    required this.id,
    required this.mode,
    required this.duration,
    required this.date,
  });

  factory BreathingModel.fromJson(
      Map<String, dynamic> json) {

    return BreathingModel(
      id: json['id'],
      mode: json['mode'],
      duration: json['duration'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "id": id,
      "mode": mode,
      "duration": duration,
      "date": date,
    };
  }
}