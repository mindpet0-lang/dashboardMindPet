import 'package:flutter/material.dart';

import '../../data/models/foro_post_model.dart';
import '../../data/services/foro_service.dart';

class ForoProvider extends ChangeNotifier {
  final ForoService _foroService = ForoService();

  List<ForoPost> _recentPosts = [];
  bool _loading = false;
  String? _errorMessage;

  List<ForoPost> get recentPosts => _recentPosts;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  int get totalPosts => _recentPosts.length;

  int get activeUsersInForum {
    final ids = _recentPosts
        .map((post) => post.usuarioId)
        .whereType<int>()
        .toSet();
    return ids.length;
  }

  int get totalMultimedia => _recentPosts.where((post) => post.hasImage).length;

  Future<void> loadForoData() async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _foroService.fetchPublicaciones();
      _recentPosts = data
        ..sort((a, b) {
          final fechaA = a.fechaCreacion;
          final fechaB = b.fechaCreacion;

          if (fechaA == null && fechaB == null) return b.id.compareTo(a.id);
          if (fechaA == null) return 1;
          if (fechaB == null) return -1;

          return fechaB.compareTo(fechaA);
        });
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
