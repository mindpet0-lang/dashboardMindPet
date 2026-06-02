import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/chatbot_model.dart';
import '../../widgets/chatbot/chatbot_message_card.dart';
import '../../widgets/layout/app_layout.dart';
import '../providers/chatbot_provider.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ChatbotProvider>().cargarMensajesReales();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatbotProvider>(
      builder: (context, provider, _) {
        final messages = provider.messages;
        final stats = _buildUserStats(messages);
        final userLabels = stats.keys.toList();
        final maxY = stats.values.isEmpty
            ? 10.0
            : _asDouble(stats.values.reduce((a, b) => a > b ? a : b)) + 3;

        return AppLayout(
          title: "MindPet AI - Panel de Control",
          currentIndex: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              final tableHeight = isMobile
                  ? 420.0
                  : (constraints.maxHeight - 390).clamp(360.0, 620.0);

              return RefreshIndicator(
                onRefresh: provider.cargarMensajesReales,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(isMobile ? 14 : 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - (isMobile ? 28 : 32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(provider),
                        const SizedBox(height: 20),
                        if (provider.errorMessage != null) ...[
                          _buildErrorBanner(provider),
                          const SizedBox(height: 20),
                        ],
                        const Text(
                          "Volumen de Interacciones por Usuario",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildChartCard(provider, stats, userLabels, maxY),
                        const SizedBox(height: 25),
                        const Text(
                          "Registros de Auditoria",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: tableHeight,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.01),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              child: ChatbotMessageCard(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Map<String, int> _buildUserStats(List<ChatbotModel> messages) {
    final stats = <String, int>{};

    for (final msg in messages) {
      final label = "Usuario #${msg.userId}";
      stats[label] = (stats[label] ?? 0) + 1;
    }

    return stats;
  }

  Widget _buildHeader(ChatbotProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Historial de Mensajes de la IA",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            provider.isLoading
                ? "Cargando historial desde PostgreSQL..."
                : "Conexion directa con PostgreSQL - ${provider.messages.length} filas detectadas",
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(
    ChatbotProvider provider,
    Map<String, int> stats,
    List<String> userLabels,
    double maxY,
  ) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : stats.isEmpty
          ? const Center(child: Text("No hay datos suficientes para graficar"))
          : BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(enabled: true),
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= userLabels.length) {
                          return const SizedBox.shrink();
                        }

                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            userLabels[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(userLabels.length, (index) {
                  final usuario = userLabels[index];
                  final cantidad = _asDouble(stats[usuario]);

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: cantidad,
                        color: const Color(0xFF4F46E5),
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
    );
  }

  Widget _buildErrorBanner(ChatbotProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFDC2626)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Color(0xFF991B1B), fontSize: 13),
            ),
          ),
          TextButton.icon(
            onPressed: provider.cargarMensajesReales,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }

  double _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
