import 'package:flutter/material.dart';

import '../../data/services/emotion_service.dart';


class EmotionProvider
    extends ChangeNotifier {

  final EmotionService
      _emotionService =
      EmotionService();

  List emotions = [];

  bool loading = false;

  Future<void> loadEmotions()
  async {

    loading = true;

    notifyListeners();

    emotions =
        await _emotionService
            .getEmotions();

    loading = false;

    notifyListeners();
  }

  Future<void> saveEmotion({

    required String emotion,
    required String note,
    required int intensity,

  }) async {

    await _emotionService
        .saveEmotion(

      emotion: emotion,
      note: note,
      intensity: intensity,
    );

    await loadEmotions();
  }
}