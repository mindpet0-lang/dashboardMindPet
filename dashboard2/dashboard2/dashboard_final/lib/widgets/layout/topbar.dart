import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_provider.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/routes/app_routes.dart';

class TopBar extends StatelessWidget {

  final String title;
  final bool isMobile;

  const TopBar({
    super.key,
    required this.title,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(
      context,
    );

    final isDark =
        themeProvider.themeMode ==
            ThemeMode.dark;

    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 16,
      ),

      decoration: BoxDecoration(

        color:
            Theme.of(context).cardColor,

        boxShadow: [

          BoxShadow(

            color: Colors.black
                .withOpacity(0.05),

            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Row(

            children: [

              if (isMobile)
  Builder(
    builder: (context) => Padding(
      padding: const EdgeInsets.only(right: 12),
      child: IconButton(
        icon: const Icon(Icons.menu),
        color: AppColors.primary,
        iconSize: 28,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
  ),

              Text(

                title,

                style: TextStyle(

                  fontSize:
                      isMobile ? 20 : 26,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                ),
              ),
            ],
          ),

          Row(

            children: [

              Container(

                decoration: BoxDecoration(

                  color: isDark
                      ? AppColors.darkCard
                      : AppColors.lightBackground,

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: IconButton(

                  tooltip:
                      isDark
                          ? "Modo día"
                          : "Modo noche",

                  icon: AnimatedSwitcher(

                    duration:
                        const Duration(
                      milliseconds: 300,
                    ),

                    child: Icon(

                      isDark
                          ? Icons.light_mode
                          : Icons.dark_mode,

                      key: ValueKey(
                        isDark,
                      ),

                      color:
                          AppColors.primary,
                    ),
                  ),

                  onPressed: () {

                    themeProvider
                        .toggleTheme();
                  },
                ),
              ),

              const SizedBox(width: 12),

              PopupMenuButton(

                offset:
                    const Offset(0, 50),

                itemBuilder: (context) => [

                  const PopupMenuItem(

                    value: 'logout',

                    child: Row(

                      children: [

                        Icon(Icons.logout),

                        SizedBox(width: 10),

                        Text(
                          "Cerrar sesión",
                        ),
                      ],
                    ),
                  ),
                ],

                onSelected: (value) {

                  if (value == 'logout') {

                    Provider.of<AuthProvider>(

                      context,

                      listen: false,

                    ).logout();

                    Navigator.pushNamedAndRemoveUntil(

                      context,

                      AppRoutes.login,

                      (route) => false,
                    );
                  }
                },

                child: Container(

                  padding:
                      const EdgeInsets.all(2),

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,

                    gradient: LinearGradient(

                      colors: [

                        AppColors.primary,
                        AppColors.secondary,
                      ],
                    ),
                  ),

                  child: const CircleAvatar(

                    radius: 20,

                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//hola