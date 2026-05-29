import 'package:flutter/material.dart';

class AppTextStyles {

  // TITULOS PRINCIPALES
  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // SUBTITULOS
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  // BODY TEXT
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: Colors.grey,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    color: Colors.grey,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  // BOTONES
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}