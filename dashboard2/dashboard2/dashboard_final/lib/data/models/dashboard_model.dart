class DashboardModel {

  final int moodScore;
  final int meditationMinutes;
  final int journalEntries;
  final int streak;
  final double stressLevel;
  final List<double> weeklyMood;
  final List<Map<String, dynamic>> emotions;

  DashboardModel({
    required this.moodScore,
    required this.meditationMinutes,
    required this.journalEntries,
    required this.streak,
    required this.stressLevel,
    required this.weeklyMood,
    required this.emotions,
  });

  factory DashboardModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return DashboardModel(

      moodScore:
          json['moodScore'] ?? 0,

      meditationMinutes:
          json['meditationMinutes'] ?? 0,

      journalEntries:
          json['journalEntries'] ?? 0,

      streak:
          json['streak'] ?? 0,

      stressLevel:
          (json['stressLevel'] ?? 0)
              .toDouble(),

      weeklyMood:
          List<double>.from(
        (json['weeklyMood'] ?? [])
            .map(
          (e) => (e as num)
              .toDouble(),
        ),
      ),

      emotions:
          List<Map<String, dynamic>>.from(
        json['emotions'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'moodScore': moodScore,

      'meditationMinutes':
          meditationMinutes,

      'journalEntries':
          journalEntries,

      'streak': streak,

      'stressLevel': stressLevel,

      'weeklyMood': weeklyMood,

      'emotions': emotions,
    };
  }
}
//hola