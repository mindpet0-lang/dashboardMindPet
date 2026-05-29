import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  // Helper para asignar un color "zen" según la emoción mapeada del backend
  Color _getEmotionColor(String? emocion) {
    switch (emocion?.toLowerCase()) {
      case 'feliz':
      case 'alegre':
        return const Color(0xFFA7F3D0); // Verde menta
      case 'triste':
      case 'ansioso':
        return const Color(0xFFBFDBFE); // Azul calma
      case 'enojado':
        return const Color(0xFFFCA5A5); // Rojo pastel
      default:
        return AppColors.primary; // Color principal por defecto
    }
  }

  Widget _buildGridSection(DashboardProvider provider, bool isMobile, Color textColor) {
    final List<dynamic> diariosReales = provider.stats["recentDiarios"] ?? [];
    final List<dynamic> usuariosReales = provider.stats["recentUsuarios"] ?? [];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: isMobile ? 1.2 : 1.5,
      children: [
        // 👥 COMPONENTE 1 NUEVO: Lista de Últimos Usuarios Registrados (Reemplazó al PieChart)
        _buildCardContainer(
          title: "Últimos Usuarios Registrados",
          textColor: textColor,
          child: Expanded(
            child: usuariosReales.isEmpty
                ? const Center(
                    child: Text(
                      "No hay usuarios registrados. 🌿",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: usuariosReales.length > 4 ? 4 : usuariosReales.length,
                    itemBuilder: (context, index) {
                      final usuario = usuariosReales[index];
                      final String nombre = usuario['nombre'] ?? 'Sin nombre';
                      final String correo = usuario['correo'] ?? '';
                      final String? fotoPerfil = usuario['fotoPerfil'];
                      final String rol = usuario['rol'] ?? 'USER';
                      final int monedas = usuario['monedas'] ?? 0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                              backgroundImage: (fotoPerfil != null && fotoPerfil.isNotEmpty && !fotoPerfil.startsWith('http'))
                                  ? MemoryImage(base64Decode(fotoPerfil))
                                  : (fotoPerfil != null && fotoPerfil.startsWith('http'))
                                      ? NetworkImage(fotoPerfil) as ImageProvider
                                      : null,
                              child: (fotoPerfil == null || fotoPerfil.isEmpty)
                                  ? const Icon(Icons.person, size: 18, color: AppColors.primary)
                                  : null,
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
                                        nombre,
                                        style: AppTextStyles.body.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: textColor,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: rol == 'ADMIN' 
                                              ? const Color(0xFFFEE2E2) 
                                              : const Color(0xFFE0F2FE),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          rol,
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: rol == 'ADMIN' 
                                                ? const Color(0xFFEF4444) 
                                                : const Color(0xFF0284C7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          correo,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.monetization_on, size: 12, color: Colors.amber),
                                          const SizedBox(width: 2),
                                          Text(
                                            "$monedas",
                                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),

        // 📝 COMPONENTE 2: Últimas entradas reales globales conectadas al Backend
        _buildCardContainer(
          title: "Últimas Entradas Registradas",
          textColor: textColor,
          child: Expanded(
            child: diariosReales.isEmpty
                ? const Center(
                    child: Text(
                      "No hay entradas de diario registradas. 🌿",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: diariosReales.length > 4 ? 4 : diariosReales.length,
                    itemBuilder: (context, index) {
                      final diario = diariosReales[index];
                      final String titulo = diario['titulo'] ?? 'Sin título';
                      final String contenido = diario['contenido'] ?? '';
                      final String? emocion = diario['emocion'];
                      final int usuarioId = diario['usuarioId'] ?? 0;

                      return _RecentEntryRow(
                        title: titulo.isNotEmpty ? titulo : "Sin título",
                        content: contenido,
                        userId: usuarioId,
                        iconColor: _getEmotionColor(emocion),
                      );
                    },
                  ),
          ),
        ),

        // 📊 COMPONENTE 3: Barras de Análisis de la IA
       // _buildCardContainer(
       //   title: "Análisis Promedio IA Global",
       //   textColor: textColor,
       //   child: Column(
       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       //     children: const [
       //       _ProgressBarRow(label: "Calma", percentage: 0.80, color: AppColors.secondary),
       //       _ProgressBarRow(label: "Estrés", percentage: 0.30, color: AppColors.primary),
       //       _ProgressBarRow(label: "Ansiedad", percentage: 0.25, color: AppColors.accent),
       //     ],
       //   ),
       // ),
//
       // // 🗺️ COMPONENTE 4: Mapa dinámico
       // _buildCardContainer(
       //   title: "Focos de Alerta (Bogotá)",
       //   textColor: textColor,
       //   child: const Expanded(
       //     child: MovableMapWidget(),
       //   ),
       // ),
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

// Widget auxiliar para las filas de los Diarios
class _RecentEntryRow extends StatelessWidget {
  final String title;
  final String content;
  final int userId;
  final Color iconColor;

  const _RecentEntryRow({
    required this.title,
    required this.content,
    required this.userId,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Icon(Icons.circle, size: 8, color: iconColor),
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
                      title,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: isDark ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      "UID: $userId",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para las barras de progreso
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