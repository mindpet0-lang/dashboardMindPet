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
      return const Center(
        child: Text(
          "No hay registros disponibles en la tabla MESSAGE",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color(0xFF6366F1),
        onPressed: () => provider.cargarMensajesReales(),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.grey.withOpacity(0.15),
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
              ),
              columnSpacing: 35,
              columns: const [
                DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Remitente', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Contenido', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Timestamp', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Usuario ID', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: realMessages.map((msg) {
                return DataRow(
                  cells: [
                    DataCell(Text(msg.id.toString())),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: msg.isUser 
                              ? const Color(0xFF8B5CF6).withOpacity(0.12) 
                              : const Color(0xFF06B6D4).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: msg.isUser ? const Color(0xFF8B5CF6) : const Color(0xFF06B6D4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          msg.sender,
                          style: TextStyle(
                            color: msg.isUser ? const Color(0xFF8B5CF6) : const Color(0xFF06B6D4),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: Text(
                          msg.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    DataCell(Text(msg.timestamp)),
                    DataCell(Text(msg.userId.toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}