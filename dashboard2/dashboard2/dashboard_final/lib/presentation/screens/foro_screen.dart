import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/foro_post_model.dart';
import '../../widgets/layout/app_layout.dart';
import '../providers/foro_provider.dart';

class ForoScreen extends StatefulWidget {
  const ForoScreen({super.key});

  @override
  State<ForoScreen> createState() => _ForoScreenState();
}

class _ForoScreenState extends State<ForoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<ForoProvider>(context, listen: false).loadForoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForoProvider>(
      builder: (context, provider, _) => _buildForoContent(context, provider),
    );
  }

  Widget _buildForoContent(BuildContext context, ForoProvider provider) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final useSingleColumnStats = MediaQuery.of(context).size.width < 520;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return AppLayout(
      title: "Control del Foro",
      currentIndex: 3,
      child: RefreshIndicator(
        onRefresh: provider.loadForoData,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 14 : 20),
          physics: const AlwaysScrollableScrollPhysics(),
          child: provider.loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(textColor),
                    const SizedBox(height: 24),
                    GridView.count(
                      crossAxisCount: useSingleColumnStats
                          ? 1
                          : isMobile
                          ? 2
                          : 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: useSingleColumnStats
                          ? 2.3
                          : isMobile
                          ? 1.35
                          : 1.4,
                      children: [
                        _buildStatMiniCard(
                          title: "Total Posts",
                          value: "${provider.totalPosts}",
                          icon: Icons.forum_rounded,
                          color: const Color(0xFF8B5CF6),
                        ),
                        _buildStatMiniCard(
                          title: "Autores Activos",
                          value: "${provider.activeUsersInForum}",
                          icon: Icons.people_alt_rounded,
                          color: const Color(0xFF10B981),
                        ),
                        _buildStatMiniCard(
                          title: "Multimedia",
                          value: "${provider.totalMultimedia}",
                          icon: Icons.image_rounded,
                          color: const Color(0xFF06B6D4),
                        ),
                        _buildStatMiniCard(
                          title: "Estado Foro",
                          value: provider.errorMessage == null
                              ? "Activo"
                              : "Error",
                          icon: provider.errorMessage == null
                              ? Icons.check_circle_outline_rounded
                              : Icons.error_outline_rounded,
                          color: provider.errorMessage == null
                              ? const Color(0xFF6366F1)
                              : const Color(0xFFDC2626),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    if (provider.errorMessage != null) ...[
                      _buildErrorBanner(provider),
                      const SizedBox(height: 20),
                    ],
                    Text(
                      "Historial de Publicaciones Recientes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.15),
                        ),
                      ),
                      child: provider.recentPosts.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Center(
                                child: Text("No hay publicaciones registradas"),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.recentPosts.length,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey.withValues(alpha: 0.15),
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                final post = provider.recentPosts[index];
                                return _buildPostRow(post, isDark);
                              },
                            ),
                    ),
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
          "Foro de la comunidad",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Publicaciones, autores y actividad compartida por los usuarios.",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildErrorBanner(ForoProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              style: const TextStyle(
                color: Color(0xFF991B1B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: provider.loadForoData,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }

  Widget _buildPostRow(ForoPost post, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
            child: const Icon(Icons.person, color: Color(0xFF8B5CF6), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.autor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      _formatDate(post.fechaCreacion),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Post #${post.id}${post.usuarioId != null ? ' - UID: ${post.usuarioId}' : ''}",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.contenido.isEmpty ? 'Sin contenido' : post.contenido,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : const Color(0xFF334155),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          if (post.hasImage) ...[
            const SizedBox(width: 12),
            const Icon(
              Icons.image_outlined,
              color: Color(0xFF06B6D4),
              size: 20,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Reciente';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  Widget _buildStatMiniCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: color, size: 22),
            ],
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
