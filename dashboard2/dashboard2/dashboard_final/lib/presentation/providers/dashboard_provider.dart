import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  static const String baseUrl = "https://backendmindpet-production.up.railway.app";

  Map<String, dynamic> stats = {};

  bool loading = false;
Future<void> loadStats() async {
  try {
    loading = true;
    notifyListeners();

    // Definimos los tres endpoints correspondientes
    final statsUrl = Uri.parse("$baseUrl/api/dashboard/stats");
    final diariosUrl = Uri.parse("$baseUrl/diarios/listar");
    final usuariosUrl = Uri.parse("$baseUrl/usuarios/rol/USUARIO");

    // Ejecutamos las tres peticiones HTTP de forma simultánea
    final responses = await Future.wait([
      http.get(statsUrl),
      http.get(diariosUrl),
      http.get(usuariosUrl),
    ]);

    final responseStats = responses[0];
    final responseDiarios = responses[1];
    final responseUsuarios = responses[2];

    // 1. Estadísticas base del dashboard
    if (responseStats.statusCode == 200) {
      stats = jsonDecode(responseStats.body);
      debugPrint("¡Estadísticas conectadas!");
    } else {
      debugPrint("Error en servidor (Stats): ${responseStats.statusCode}");
    }

    // 2. Diarios globales ("recentDiarios")
    if (responseDiarios.statusCode == 200) {
      final List<dynamic> listaDiarios = jsonDecode(utf8.decode(responseDiarios.bodyBytes));
      stats["recentDiarios"] = listaDiarios.reversed.toList();
      debugPrint("¡Diarios globales agregados!");
    }

    // 3. Usuarios globales ("recentUsuarios")
    if (responseUsuarios.statusCode == 200) {
      final List<dynamic> listaUsuarios = jsonDecode(utf8.decode(responseUsuarios.bodyBytes));
      
      // Los invertimos para ver los últimos creados/registrados arriba
      stats["recentUsuarios"] = listaUsuarios.reversed.toList();
      debugPrint("¡Usuarios globales agregados a la lista!");
    } else {
      debugPrint("Error en servidor (Usuarios): ${responseUsuarios.statusCode}");
    }

  } catch (e) {
    debugPrint("Error de conexión general en el Dashboard: $e");
  } finally {
    loading = false;
    notifyListeners();
  }
}
  
}
//hola