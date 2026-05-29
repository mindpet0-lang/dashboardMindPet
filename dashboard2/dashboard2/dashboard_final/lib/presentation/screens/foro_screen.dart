import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    // Ejecuta la carga de datos de la base de datos real de forma segura
    Future.microtask(() {
      try {
        Provider.of<ForoProvider>(context, listen: false).loadForoData();
      } catch (e) {
        print("Esperando a la inicialización del contexto local del foro.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🛡️ TRUCO DE INYECCIÓN SEGURA: Si por alguna razón el Sidebar aísla esta pantalla,
    // usamos un Builder alternativo para evitar que la aplicación lance la pantalla roja.
    try {
      final provider = Provider.of<ForoProvider>(context);
      return _buildForoContent(context, provider);
    } catch (_) {
      // Si el árbol de contexto falló debido al menú indexado, creamos un Provider local en caliente
      return ChangeNotifierProvider<ForoProvider>(
        create: (_) => ForoProvider()..loadForoData(),
        child: Consumer<ForoProvider>(
          builder: (context, localProvider, _) => _buildForoContent(context, localProvider),
        ),
      );
    }
  }

  // Separamos el contenido visual para mantenerlo limpio y ordenado
  Widget _buildForoContent(BuildContext context, ForoProvider provider) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return AppLayout(
      title: "Control del Foro",
      currentIndex: 3, 
      child: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => provider.loadForoData(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: isMobile ? 2 : 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isMobile ? 1.2 : 1.4,
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
                          value: "${provider.recentPosts.where((p) => p['hasImage']).length}",
                          icon: Icons.image_rounded,
                          color: const Color(0xFF06B6D4),
                        ),
                        _buildStatMiniCard(
                          title: "Estado Foro",
                          value: "Activo",
                          icon: Icons.check_circle_outline_rounded,
                          color: const Color(0xFF6366F1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

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
                        border: Border.all(color: Colors.grey.withOpacity(0.15)),
                      ),
                      child: provider.recentPosts.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Center(child: Text("No hay publicaciones registradas")),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.recentPosts.length,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey.withOpacity(0.15),
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                final post = provider.recentPosts[index];
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                                        child: Text(
                                          "U${post['userId']}",
                                          style: const TextStyle(
                                            color: Color(0xFF8B5CF6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Post #${post['id']}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "${post['date']}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              post['content'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isDark ? Colors.grey[300] : const Color(0xFF334155),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (post['hasImage']) ...[
                                        const SizedBox(width: 12),
                                        const Icon(
                                          Icons.image_outlined,
                                          color: Color(0xFF06B6D4),
                                          size: 20,
                                        ),
                                      ]
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
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
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Icon(icon, color: color, size: 22),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}