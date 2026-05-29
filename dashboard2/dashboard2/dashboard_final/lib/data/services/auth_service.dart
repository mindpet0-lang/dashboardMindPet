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

      print(response.body);

      if (response.statusCode == 200) {

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

  Future<Map<String, dynamic>?> register(
    String nombre,
    String correo,
    String contrasena,
    String rol,
  ) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          "$baseUrl/register",
        ),

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "nombre": nombre,
          "correo": correo,
          "contrasena": contrasena,
          "rol": rol,
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