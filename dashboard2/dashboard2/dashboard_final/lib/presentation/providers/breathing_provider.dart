import 'dart:async';

import 'package:flutter/material.dart';

class BreathingProvider
    extends ChangeNotifier {

  double scale = 1;

  String phase = "Inhala";

  int seconds = 0;

  Timer? timer;

  void startBreathing() {

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {

        if (scale == 1) {

          scale = 1.3;
          phase = "Exhala";

        } else {

          scale = 1;
          phase = "Inhala";
        }

        seconds += 4;

        notifyListeners();
      },
    );
  }

  void stopBreathing() {

    timer?.cancel();
  }

  @override
  void dispose() {

    timer?.cancel();
    super.dispose();
  }
}