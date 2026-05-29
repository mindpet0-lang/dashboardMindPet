import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/dashboard_provider.dart';
import '../../widgets/layout/app_layout.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/maps/movable_map_widget.dart'; 

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DashboardProvider>(context, listen: false).loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 900;
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return AppLayout(
      title: "MindPet",
      currentIndex: 0,
      child: provider.loading 
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => provider.loadStats(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(textColor),
                    const SizedBox(height: 24),
                    
                    _buildStatCards(provider),
                    const SizedBox(height: 32),

                    _buildGridSection(provider, isMobile, textColor),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Panel de Administración",
          style: AppTextStyles.heading.copyWith(color: textColor),
        ),
        const SizedBox(height: 4),
        Text(
          "Métricas del sistema y actividad de usuarios en tiempo real.",
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }

  Widget _buildStatCards(DashboardProvider provider) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        StatCard(
          title: "Sesiones",
          value: (provider.stats["totalSessions"] ?? 0).toString(),
          icon: Icons.favorite,
        ),
        StatCard(
          title: "Meditaciones",
          value: (provider.stats["totalMeditations"] ?? 0).toString(),
          icon: Icons.self_improvement,
        ),
        StatCard(
          title: "Estado positivo",
          value: "${provider.stats["positivePercentage"] ?? 0}%",
          icon: Icons.mood,
        ),
      ],
    );
  }

  Widget _buildGridSection(DashboardProvider provider, bool isMobile, Color textColor) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: isMobile ? 1.2 : 1.5,
      children: [
        _buildCardContainer(
          title: "Distribución Base de Datos",
          textColor: textColor,
          child: Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: (provider.stats["happyCount"] ?? 0).toDouble(),
                    title: 'Feliz',
                    color: AppColors.secondary,
                    radius: 45,
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                  ),
                  PieChartSectionData(
                    value: (provider.stats["sadCount"] ?? 0).toDouble(),
                    title: 'Triste',
                    color: AppColors.primary,
                    radius: 45,
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                  ),
                  PieChartSectionData(
                    value: (provider.stats["anxietyCount"] ?? 0).toDouble(),
                    title: 'Ansiedad',
                    color: AppColors.accent,
                    radius: 45,
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),

        _buildCardContainer(
          title: "Últimas Entradas Registradas",
          textColor: textColor,
          child: Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: const [
                _RecentEntryRow(text: "Hoy me sentí más tranquila 🌿"),
                _RecentEntryRow(text: "La respiración me ayudó bastante 💜"),
                _RecentEntryRow(text: "Tuve ansiedad en la tarde"),
                _RecentEntryRow(text: "Dormí mejor que ayer ✨"),
              ],
            ),
          ),
        ),

        _buildCardContainer(
          title: "Análisis Promedio IA Global",
          textColor: textColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ProgressBarRow(label: "Calma", percentage: 0.80, color: AppColors.secondary),
              _ProgressBarRow(label: "Estrés", percentage: 0.30, color: AppColors.primary),
              _ProgressBarRow(label: "Ansiedad", percentage: 0.25, color: AppColors.accent),
            ],
          ),
        ),

        // 🗺️ COMPONENTE 4 MODIFICADO: ¡Tu mapa dinámico de Bogotá en acción!
        _buildCardContainer(
          title: "Focos de Alerta (Bogotá)",
          textColor: textColor,
          child: const Expanded(
            child: MovableMapWidget(), // Reemplazado por tu widget interactivo de OpenStreetMap
          ),
        ),
      ],
    );
  }

  Widget _buildCardContainer({required String title, required Widget child, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(color: textColor, fontSize: 16),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _RecentEntryRow extends StatelessWidget {
  final String text;
  const _RecentEntryRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : const Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBarRow extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _ProgressBarRow({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
            Text("${(percentage * 100).toInt()}%", style: AppTextStyles.bodySmall),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: color.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}