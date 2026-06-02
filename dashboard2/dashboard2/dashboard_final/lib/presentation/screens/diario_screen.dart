import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/layout/app_layout.dart';
import '../../widgets/diario/diary_sumary_card.dart';
import '../../widgets/diario/mood_indicator.dart';

class DiarioScreen extends StatefulWidget {
  const DiarioScreen({super.key});

  @override
  State<DiarioScreen> createState() => _DiarioScreenState();
}

class _DiarioScreenState extends State<DiarioScreen> {
  final String baseUrl = "https://backendmindpet-production.up.railway.app";

  List<dynamic> diarioEntradas = [];
  bool isLoading = true;
  int totalEntradas = 0;

  int cantidadFelicidad = 0;
  int cantidadOtrasEmociones = 0;

  @override
  void initState() {
    super.initState();
    _cargarDatosDelBack();
  }

  Future<void> _cargarDatosDelBack() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse("$baseUrl/diarios/listar"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          diarioEntradas = data;
          totalEntradas = diarioEntradas.length;
          _calcularCantidadesReales(data);
          isLoading = false;
        });
      } else {
        throw Exception("Error del servidor: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _mostrarSnackbar("Error al cargar datos: $e");
    }
  }

  Future<void> _editarEntradaEnBaseDatos(
    int id,
    String nuevoTitulo,
    String emocionOriginal,
    String nuevoContenido,
    int usuarioId,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/diarios/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": id,
          "titulo": nuevoTitulo,
          "emocion": emocionOriginal,
          "contenido": nuevoContenido,
          "usuarioId": usuarioId,
          "usuario_id": usuarioId,
          "usuario": {"id": usuarioId},
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _mostrarSnackbar("Entrada ID $id modificada con éxito.");
        _cargarDatosDelBack();
      } else {
        _mostrarSnackbar(
          "Error del servidor al actualizar. Código: ${response.statusCode}",
        );
      }
    } catch (e) {
      _mostrarSnackbar("Error de red al actualizar: $e");
    }
  }

  Future<void> _eliminarEntrada(int id, int usuarioId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/diarios/$id/usuario/$usuarioId"),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          diarioEntradas.removeWhere((e) => e['id'] == id);
          totalEntradas = diarioEntradas.length;
          _calcularCantidadesReales(diarioEntradas);
        });
        _mostrarSnackbar("Registro eliminado de MySQL.");
      } else {
        _mostrarSnackbar("Error al eliminar. Status: ${response.statusCode}");
      }
    } catch (e) {
      _mostrarSnackbar("Error de conexión: $e");
    }
  }

  void _calcularCantidadesReales(List<dynamic> entradas) {
    if (entradas.isEmpty) {
      cantidadFelicidad = 0;
      cantidadOtrasEmociones = 0;
      return;
    }
    cantidadFelicidad = entradas
        .where(
          (e) =>
              e['emocion'] == 'Amor' ||
              e['emocion'] == 'Feliz' ||
              e['emocion'] == 'Felicidad',
        )
        .length;
    cantidadOtrasEmociones = entradas.length - cantidadFelicidad;
  }

  void _mostrarVentanaEditar(
    BuildContext context,
    Map<String, dynamic> entrada,
  ) {
    final tituloController = TextEditingController(text: entrada['titulo']);
    final String contenidoOriginal = entrada['contenido'] ?? '';
    final String emocionOriginal = entrada['emocion'] ?? "Feliz";
    final int usuarioId =
        entrada['usuarioId'] ??
        entrada['usuario_id'] ??
        (entrada['usuario'] != null ? entrada['usuario']['id'] : 1);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Moderar Registro (ID: ${entrada['id']})"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: "Modificar Título",
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Emoción registrada:",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Chip(
                  label: Text(emocionOriginal),
                  backgroundColor: const Color(
                    0xFF06B6D4,
                  ).withValues(alpha: 0.1),
                  labelStyle: const TextStyle(
                    color: Color(0xFF06B6D4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text(
                    "🔒 Contenido privado oculto por seguridad.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
              ),
              onPressed: () {
                _editarEntradaEnBaseDatos(
                  entrada['id'],
                  tituloController.text,
                  emocionOriginal,
                  contenidoOriginal,
                  usuarioId,
                );
                Navigator.pop(context);
              },
              child: const Text(
                "Guardar Cambios",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarSnackbar(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return AppLayout(
      title: "Diario emocional",
      currentIndex: 1,
      child: RefreshIndicator(
        onRefresh: _cargarDatosDelBack,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(isMobile ? 14 : 20),
          child: isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildUpperWidgetsMobile(),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DiarySummaryCard(
                              title: "Entradas al diario",
                              value: totalEntradas.toString(),
                              icon: Icons.book,
                              color: const Color(0xFF8B5CF6),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MoodIndicator(
                                  mood: "Felicidad",
                                  percentage: cantidadFelicidad.toDouble(),
                                  color: const Color(0xFF06B6D4),
                                  icon: Icons.sentiment_very_satisfied,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: MoodIndicator(
                                  mood: "Otras Emociones",
                                  percentage: cantidadOtrasEmociones.toDouble(),
                                  color: const Color(0xFF6366F1),
                                  icon: Icons.bubble_chart,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    const SizedBox(height: 32),

                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Historial del Diario (MySQL)",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            if (diarioEntradas.isEmpty)
                              const Center(
                                child: Text(
                                  "No se encontraron registros de usuarios.",
                                ),
                              )
                            else
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: 60,
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'ID',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Usuario Propietario',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Título de Referencia',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Emoción Detectada',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Acciones',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: diarioEntradas.map((entrada) {
                                    final int currentUsuarioId =
                                        entrada['usuarioId'] ??
                                        entrada['usuario_id'] ??
                                        (entrada['usuario'] != null
                                            ? entrada['usuario']['id']
                                            : 1);

                                    // 💡 Extrae el nombre real desde el objeto relacional 'usuario' devuelto por Spring Boot / MySQL
                                    final String nombreUsuario =
                                        entrada['usuario'] != null &&
                                            entrada['usuario']['nombre'] != null
                                        ? entrada['usuario']['nombre']
                                              .toString()
                                        : "Usuario #$currentUsuarioId";

                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(entrada['id'].toString()),
                                        ),
                                        // ✨ Muestra el nombre real de registro aquí
                                        DataCell(
                                          Text(
                                            nombreUsuario,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            child: Text(
                                              entrada['titulo'] ?? '',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Chip(
                                            label: Text(
                                              entrada['emocion'] ??
                                                  'Sin asignar',
                                            ),
                                            backgroundColor: const Color(
                                              0xFF06B6D4,
                                            ).withValues(alpha: 0.1),
                                            labelStyle: const TextStyle(
                                              color: Color(0xFF06B6D4),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_note,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () =>
                                                    _mostrarVentanaEditar(
                                                      context,
                                                      Map<String, dynamic>.from(
                                                        entrada,
                                                      ),
                                                    ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () =>
                                                    _eliminarEntrada(
                                                      entrada['id'],
                                                      currentUsuarioId,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildUpperWidgetsMobile() {
    return [
      DiarySummaryCard(
        title: "Entradas al diario",
        value: totalEntradas.toString(),
        icon: Icons.book,
        color: const Color(0xFF8B5CF6),
      ),
      const SizedBox(height: 16),
      MoodIndicator(
        mood: "Felicidad",
        percentage: cantidadFelicidad.toDouble(),
        color: const Color(0xFF06B6D4),
        icon: Icons.sentiment_very_satisfied,
      ),
      const SizedBox(height: 16),
      MoodIndicator(
        mood: "Otras Emociones",
        percentage: cantidadOtrasEmociones.toDouble(),
        color: const Color(0xFF6366F1),
        icon: Icons.bubble_chart,
      ),
    ];
  }
}
