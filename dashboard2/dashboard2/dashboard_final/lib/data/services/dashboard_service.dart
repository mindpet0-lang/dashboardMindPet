import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {

  static const String baseUrl =
      "http://10.0.2.2:8080/api";

  Future<dynamic> getDashboard() async {

    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/stats"),
    );

    if (response.statusCode == 200) {

      return jsonDecode(response.body);

    } else {

      throw Exception(
        "Error: ${response.statusCode}",
      );
    }
  }
}