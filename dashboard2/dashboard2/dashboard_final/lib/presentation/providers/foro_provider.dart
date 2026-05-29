import 'package:flutter/material.dart';
import '../../data/services/foro_service.dart';

class ForoProvider extends ChangeNotifier {
  // Instanciamos nuestro servicio limpio
  final ForoService _foroService = ForoService();

  bool _loading = false;
  int _totalPosts = 0;
  int _activeUsersInForum = 0;
  List<Map<String, dynamic>> _recentPosts = [];

  bool get loading => _loading;
  int get totalPosts => _totalPosts;
  int get activeUsersInForum => _activeUsersInForum;
  List<Map<String, dynamic>> get recentPosts => _recentPosts;

  Future<void> loadForoData() async {
    _loading = true;
    notifyListeners();

    try {
      // Consumimos el servicio web
      final List<dynamic> data = await _foroService.fetchPublicaciones();
      print("¡Provider recibió datos desde el Service con éxito!");
      
      _totalPosts = data.length;

      // Obtener usuarios únicos activos basados en tu columna 'usuario_id'
      final uniqueUsers = data.map((post) => post['usuario_id'] ?? post['usuarioId'] ?? 0).toSet();
      _activeUsersInForum = uniqueUsers.length;

      // Mapear los posts de la base de datos real
      _recentPosts = data.map((post) {
        String originalContent = post['contenido'] ?? post['content'] ?? '';
        
        String cleanText = originalContent;
        bool hasImage = originalContent.contains('[IMG]');
        if (hasImage) {
          cleanText = originalContent.split('[IMG]').first.trim();
          if (cleanText.isEmpty) cleanText = "Publicó una imagen interactiva 🖼️";
        }

        return {
          "id": post['id'],
          "content": cleanText,
          "date": post['fecha_creacion'] ?? post['fechaCreacion'] ?? '',
          "userId": post['usuario_id'] ?? post['usuarioId'] ?? 0,
          "hasImage": hasImage
        };
      }).toList().reversed.toList(); // Los nuevos primero

    } catch (e) {
      print("Error en Provider: $e. Activando plan de respaldo visual.");
      _cargarDatosDeRespaldo();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Plan B por si el servidor de Railway se apaga o está lento
  void _cargarDatosDeRespaldo() {
    _totalPosts = 4;
    _activeUsersInForum = 2;
    _recentPosts = [
      {"id": 4, "content": "HOLI", "date": "2026-05-28 14:31:28", "userId": 2, "hasImage": true},
      {"id": 3, "content": "La nutria es muy linda 😁🤗", "date": "2026-05-28 14:17:01", "userId": 1, "hasImage": true},
      {"id": 2, "content": "HOLA", "date": "2026-05-28 14:14:38", "userId": 2, "hasImage": false},
      {"id": 1, "content": "hola amigos :3 123", "date": "2026-05-28 14:01:38", "userId": 1, "hasImage": false},
    ];
  }
}