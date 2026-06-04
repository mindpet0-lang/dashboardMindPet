class ForoPost {
  final int id;
  final int? usuarioId;
  final String autor;
  final String contenido;
  final String? imagen;
  final DateTime? fechaCreacion;

  const ForoPost({
    required this.id,
    required this.contenido,
    this.usuarioId,
    this.autor = 'Usuario',
    this.imagen,
    this.fechaCreacion,
  });

  factory ForoPost.fromJson(Map<String, dynamic> json) {
    final usuario = json['usuario'];
    final usuarioMap = usuario is Map<String, dynamic> ? usuario : null;
    final rawContenido = _asString(json['contenido'] ?? json['descripcion']);
    final imageFromContent = _extractImage(rawContenido);
    final cleanContenido = _cleanContent(rawContenido);

    return ForoPost(
      id: _asInt(json['id']) ?? 0,
      usuarioId: _asInt(
        json['usuarioId'] ?? json['userId'] ?? usuarioMap?['id'],
      ),
      autor: _asString(
        json['autor'] ??
            json['nombreUsuario'] ??
            json['username'] ??
            usuarioMap?['nombre'] ??
            usuarioMap?['correo'],
        fallback: 'Usuario',
      ),
      contenido: cleanContenido,
      imagen: _asNullableString(
        json['imagen'] ??
            json['imageUrl'] ??
            json['foto'] ??
            json['urlImagen'] ??
            imageFromContent,
      ),
      fechaCreacion: _asDateTime(
        json['fechaCreacion'] ?? json['createdAt'] ?? json['fecha'],
      ),
    );
  }

  bool get hasImage => imagen != null && imagen!.trim().isNotEmpty;

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static String _asString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }

  static String? _asNullableString(dynamic value) {
    final text = _asString(value);
    return text.isEmpty ? null : text;
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  static String _cleanContent(String value) {
    final imageStart = value.indexOf('[IMG]');
    if (imageStart == -1) return value;

    final text = value.substring(0, imageStart).trim();
    return text.isEmpty ? 'Publicacion con imagen' : text;
  }

  static String? _extractImage(String value) {
    final match = RegExp(
      r'\[IMG\](.*?)\[/IMG\]',
      dotAll: true,
    ).firstMatch(value);
    final image = match?.group(1)?.trim();

    if (image == null || image.isEmpty) return null;
    return image;
  }
}
//hola