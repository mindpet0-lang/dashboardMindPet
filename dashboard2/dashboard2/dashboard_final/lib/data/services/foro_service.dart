import 'dart:convert';
import 'package:http/http.dart' as http;

class ForoService {
  // Tu endpoint corregido en Railway
  final String _baseUrl = 'https://backendmindpet-production.up.railway.app/publicaciones';

  Future<List<dynamic>> fetchPublicaciones() async {
    try {
      print("ForoService: Conectando con la base de datos...");
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        // Decodifica caracteres especiales como emojis o tildes correctamente
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception("Error del servidor: Código ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error de red en ForoService: $e");
    }
  }
}