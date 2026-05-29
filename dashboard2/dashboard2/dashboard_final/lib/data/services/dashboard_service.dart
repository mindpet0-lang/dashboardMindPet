import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {

  static const String baseUrl =
      "https://backendmindpet-production.up.railway.app/api";

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