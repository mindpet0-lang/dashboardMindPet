import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  
  bool loading = false;

  final String baseUrl =
      "https://backendmindpet-production.up.railway.app/usuarios";

  Future<bool> register(

    String nombre,
    String correo,
    String contrasena,
    String rol,

  ) async {

    loading = true;
    notifyListeners();

    try {

      final response = await http.post(
        Uri.parse("$baseUrl/register"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({

          "nombre": nombre,
          "correo": correo,
          "contrasena": contrasena,
          "rol": rol,

        }),
      );

      print(response.statusCode);
      print(response.body);

      loading = false;
      notifyListeners();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;

    } catch (e) {

      print(e);

      loading = false;
      notifyListeners();

      return false;
    }
  }

  Future<bool> login(String correo, String contrasena) async {
    loading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"correo": correo, "contrasena": contrasena}),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      loading = false;
      notifyListeners();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // EXTRAER EL ROL CORRECTAMENTE:
        // Si tu backend devuelve el rol directo: data['rol']
        // Si tu backend devuelve un objeto usuario: data['usuario']['rol'] o data['user']['rol']
        String? rol;

        if (data['rol'] != null) {
          rol = data['rol'];
        } else if (data['usuario'] != null && data['usuario']['rol'] != null) {
          rol = data['usuario']['rol'];
        } else if (data['user'] != null && data['user']['rol'] != null) {
          rol = data['user']['rol'];
        }

        print("Rol detectado en Flutter: '$rol'");

        // VALIDACIÓN ESTRICTA
        if (rol == 'ADMIN') {
          return true; // Es administrador, entra.
        } else {
          print(
            "Acceso denegado: El usuario tiene rol '$rol' y se requiere 'ADMIN'.",
          );
          return false;
        }
      }

      return false;
    } catch (e) {
      print("Error en login: $e");
      loading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {

    loading = false;

    notifyListeners();
  }
}
//hola