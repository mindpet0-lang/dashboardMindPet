import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  static const String baseUrl = "https://backendmindpet-production.up.railway.app/api";

  Map<String, dynamic> stats = {};

  bool loading = false;

  Future<void> loadStats() async {
    try {
      loading = true;

      notifyListeners();
      final response = await http.get(Uri.parse("$baseUrl/dashboard/stats"));

      if (response.statusCode == 200) {
        stats = jsonDecode(response.body);
        debugPrint("¡JSON conectado con éxito!: $stats");
      } else {
        debugPrint("Error en el servidor: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error de conexión: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
