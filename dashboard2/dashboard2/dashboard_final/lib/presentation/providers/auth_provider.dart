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

        Uri.parse(
          "$baseUrl/admin",
        ),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "nombre": nombre,
          "correo": correo,
          "contrasena": contrasena,
        }),
      );

      print(response.statusCode);
      print(response.body);

      loading = false;
      notifyListeners();

      if (

          response.statusCode == 200 ||

          response.statusCode == 201

      ) {

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

 Future<bool> login(
  String correo,
  String contrasena,
) async {
  loading = true;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "correo": correo,
        "contrasena": contrasena,
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    loading = false;
    notifyListeners();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      // 1. Extraer el rol del cuerpo de la respuesta
      // Nota: Si viene dentro de un objeto 'user', usa: data['user']['rol']
      final String? rol = data['rol']; 

      print("Rol del usuario: $rol");

      // 2. Validar que el rol sea estrictamente ADMIN
      if (rol == 'ADMIN') {
        return true;
      } else {
        print("Acceso denegado: El usuario no es un administrador.");
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