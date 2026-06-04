import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentNotesCard extends StatefulWidget {
  const RecentNotesCard({super.key});

  @override
  State<RecentNotesCard> createState() => _RecentNotesCardState();
}

class _RecentNotesCardState extends State<RecentNotesCard> {
  List<dynamic> _notes = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRecentNotes();
  }

  Future<void> _fetchRecentNotes() async {
    final url = Uri.parse("https://backendmindpet-production.up.railway.app/diarios/listar");
    
    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        
        setState(() {
          // Al ser Admin, tomamos todas las notas globales del backend.
          // Invertimos el orden para mostrar lo más reciente arriba y tomamos las últimas 5.
          _notes = data.reversed.take(5).toList(); 
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Error al obtener los diarios globales";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error de conexión con el servidor";
        _isLoading = false;
      });
    }
  }

  // Paleta de colores "zen" según la emoción registrada en la entidad Diario
  Color _getEmotionColor(String? emocion) {
    switch (emocion?.toLowerCase()) {
      case 'feliz':
      case 'alegre':
        return const Color(0xFFA7F3D0); // Verde menta suave
      case 'triste':
      case 'ansioso':
        return const Color(0xFFBFDBFE); // Azul calma
      case 'enojado':
        return const Color(0xFFFCA5A5); // Rojo pastel
      default:
        return const Color(0xFFC084FC); // Morado por defecto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Últimas entradas globales",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_errorMessage != null)
            Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            )
          else if (_notes.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "No hay diarios registrados en el sistema. 🌿",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
          else
            ..._notes.map(
              (diario) {
                final String titulo = diario['titulo'] ?? 'Sin título';
                final String contenido = diario['contenido'] ?? '';
                final String? emocion = diario['emocion'];
                final int usuarioId = diario['usuarioId'] ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: _getEmotionColor(emocion),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  titulo.isNotEmpty ? titulo : 'Sin título',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                // Badge pequeño que le indica al Admin a qué ID de usuario pertenece
                                Text(
                                  "User ID: $usuarioId",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              contenido,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
//hola