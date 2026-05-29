import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/breathing_model.dart';

class BreathingService {

  static const String baseUrl =
      "https://backendmindpet-production.up.railway.app/api/breathing";

  Future<List<BreathingModel>>
      getSessions() async {

    final response =
        await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data =
          jsonDecode(response.body);

      return data
          .map((e) =>
              BreathingModel.fromJson(e))
          .toList();
    }

    return [];
  }
}