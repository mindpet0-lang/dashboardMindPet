import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/foro_post_model.dart';

class ForoService {
  static const String _baseUrl =
      'https://backendmindpet-production.up.railway.app/api/publicaciones';

  Future<List<ForoPost>> fetchPublicaciones({int usuarioIdActual = 1}) async {
    final uri = Uri.parse(
      _baseUrl,
    ).replace(queryParameters: {'usuarioIdActual': usuarioIdActual.toString()});
  // Tu endpoint corregido en Railway
  final String _baseUrl = 'https://backendmindpet-production.up.railway.app/api/publicaciones';

    try {
      final request = http.Request('GET', uri);
      final response = await request.send().timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode != 200) {
        throw Exception('Error del servidor: ${response.statusCode}');
      }

      final body = await _readLimitedBody(response.stream);
      final publicaciones = _decodePublicaciones(body);

      return publicaciones
          .whereType<Map<String, dynamic>>()
          .map(ForoPost.fromJson)
          .toList();
    } catch (e) {
      throw Exception('No se pudieron cargar las publicaciones del foro. $e');
    }
  }

  Future<String> _readLimitedBody(Stream<List<int>> stream) async {
    const maxBytes = 600 * 1024;
    final buffer = BytesBuilder(copy: false);
    final stopwatch = Stopwatch()..start();

    await for (final chunk in stream.timeout(const Duration(seconds: 15))) {
      final remaining = maxBytes - buffer.length;

      if (remaining <= 0 || stopwatch.elapsed > const Duration(seconds: 12)) {
        break;
      }

      buffer.add(
        chunk.length <= remaining ? chunk : chunk.sublist(0, remaining),
      );
    }

    return utf8.decode(buffer.takeBytes(), allowMalformed: true);
  }

  List<dynamic> _decodePublicaciones(String body) {
    try {
      final decoded = json.decode(body);

      if (decoded is List) return decoded;
      if (decoded is Map<String, dynamic> && decoded['content'] is List) {
        return decoded['content'] as List;
      }
    } catch (_) {
      return _decodeCompleteObjectsFromArray(body);
    }

    return const [];
  }

  List<dynamic> _decodeCompleteObjectsFromArray(String body) {
    final objects = <dynamic>[];
    var depth = 0;
    var start = -1;
    var inString = false;
    var escaped = false;

    for (var i = 0; i < body.length; i++) {
      final char = body[i];

      if (inString) {
        if (escaped) {
          escaped = false;
        } else if (char == r'\') {
          escaped = true;
        } else if (char == '"') {
          inString = false;
        }
        continue;
      }

      if (char == '"') {
        inString = true;
      } else if (char == '{') {
        if (depth == 0) start = i;
        depth++;
      } else if (char == '}') {
        depth--;

        if (depth == 0 && start != -1) {
          try {
            objects.add(json.decode(body.substring(start, i + 1)));
          } catch (_) {
            // The stream may be intentionally truncated before the next object.
          }
          start = -1;
        }
      }
    }

    return objects;
  }
}
