import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/chatbot_provider.dart';

class ChatbotMessageCard extends StatelessWidget {
  const ChatbotMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatbotProvider>(context);
    final realMessages = provider.messages;

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6366F1)),
      );
    }

    if (realMessages.isEmpty) {
      return Center(
        child: Text(
          provider.errorMessage == null
              ? "No hay registros disponibles en la tabla MESSAGE"
              : "No se pudo cargar la tabla MESSAGE",
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.grey.withValues(alpha: 0.15)),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.6),
                ),
                columnSpacing: 35,
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Remitente',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 🔒 La columna 'Contenido' ha sido eliminada por privacidad de la auditoría.
                  DataColumn(
                    label: Text(
                      'Timestamp',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Usuario ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: realMessages.map((msg) {
                  return DataRow(
                    cells: [
                      DataCell(Text(msg.id.toString())),
                      DataCell(
                        _SenderBadge(sender: msg.sender, isUser: msg.isUser),
                      ),
                      // 🔒 Se eliminó la celda que contenía msg.content
                      DataCell(Text(msg.timestamp)),
                      DataCell(Text(msg.userId.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.small(
            backgroundColor: const Color(0xFF6366F1),
            onPressed: provider.cargarMensajesReales,
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _SenderBadge extends StatelessWidget {
  final String sender;
  final bool isUser;

  const _SenderBadge({required this.sender, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final color = isUser ? const Color(0xFF8B5CF6) : const Color(0xFF06B6D4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Text(
        sender,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}