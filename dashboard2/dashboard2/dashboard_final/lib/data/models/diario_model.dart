class DiarioEntrada {
  final int id;
  final String titulo;
  final String emocion;
  final String contenido;
  final int usuarioId;

  DiarioEntrada({
    required this.id,
    required this.titulo,
    required this.emocion,
    required this.contenido,
    required this.usuarioId,
  });

  // Convierte el JSON exacto de tu MySQL/Spring Boot a un Objeto de Dart
  factory DiarioEntrada.fromJson(Map<String, dynamic> json) {
    return DiarioEntrada(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? '',
      emocion: json['emocion'] ?? '',
      contenido: json['contenido'] ?? '',
      // Resguarda por si viene como usuario_id o usuarioId desde el back
      usuarioId: json['usuario_id'] ?? json['usuarioId'] ?? 0,
    );
  }

  // Convierte el objeto a JSON para cuando hagas la petición PUT (Editar)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titulo": titulo,
      "emocion": emocion,
      "contenido": contenido,
      "usuario_id": usuarioId,
    };
  }
}
//hola