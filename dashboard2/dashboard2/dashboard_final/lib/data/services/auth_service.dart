import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String baseUrl =
      "https://backendmindpet-production.up.railway.app/usuarios";

  Future<Map<String, dynamic>?> login(
    String correo,
    String contrasena,
  ) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          "$baseUrl/login",
        ),

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "correo": correo,
          "contrasena": contrasena,
        }),
      );


if (response.statusCode == 200) {
  final Map<String, dynamic> data = jsonDecode(response.body);

  // Validamos si tiene el rol requerido
  if (data['rol'] == 'ADMIN') {
    return data;
  } else {
    // Lanzamos un error específico para capturarlo en la UI
    throw Exception('No tienes permisos de Administrador para ingresar.');
  }
}

      return null;

    } catch (e) {

      print(e);

      return null;
    }
  }

  Future<Map<String, dynamic>?> register(
    String nombre,
    String correo,
    String contrasena,
  ) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          "$baseUrl/admin",
        ),

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "nombre": nombre,
          "correo": correo,
          "contrasena": contrasena,
        }),
      );

      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        return jsonDecode(
          response.body,
        );
      }

      return null;

    } catch (e) {

      print(e);

      return null;
    }
  }

  Future<void> saveToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "token",
      token,
    );
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();
  }
}
//hola