import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

import '../providers/auth_provider.dart';

import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

import '../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final correoController = TextEditingController();

  final contrasenaController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final size = MediaQuery.of(context).size;

    final isMobile = size.width < 800;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),

            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),

              child: isMobile
                  ? _mobileLayout(authProvider)
                  : _desktopLayout(authProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(AuthProvider authProvider) {
    return Row(
      children: [
        Expanded(child: _leftSide()),

        const SizedBox(width: 50),

        Expanded(child: _loginCard(authProvider)),
      ],
    );
  }

  Widget _mobileLayout(AuthProvider authProvider) {
    return Column(
      children: [
        _leftSide(),

        const SizedBox(height: 40),

        _loginCard(authProvider),
      ],
    );
  }

  Widget _leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reemplazo del Icono de Psicología por el Logo de la App
        Container(
          width: 86,
          height: 86,
          decoration: BoxDecoration(
            color: const Color(0xFF7B51FF), // Color morado de tu logo
            borderRadius: BorderRadius.circular(22),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: const Center(
              child: Icon(
                Icons
                    .psychology, // <-- Icono de cerebro / psicología nativo de Flutter
                size:
                    50, // Ajusta el tamaño para que quepa bien en el contenedor de 86x86
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 25),

        Text(
          "MindPet",

          style: AppTextStyles.title.copyWith(color: AppColors.primary),
        ),

        const SizedBox(height: 20),

        Text("Tu espacio emocional inteligente", style: AppTextStyles.subtitle),

        const SizedBox(height: 30),

        // Reemplazo del Icono de Corazón por la Ilustración de la Mascota
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ), // Margen para que no toque los bordes
            child: Image.asset(
              'assets/images/logowhite.png', // <-- Tu archivo de la ilustración lineal en blanco y negro
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginCard(AuthProvider authProvider) {
    return Container(
      padding: const EdgeInsets.all(32),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,

            blurRadius: 15,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Form(
        key: formKey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("Iniciar Sesión", style: AppTextStyles.title),

            const SizedBox(height: 10),

            Text("Bienvenida nuevamente", style: AppTextStyles.subtitle),

            const SizedBox(height: 35),

            // CORREO
            CustomTextField(
              controller: correoController,

              hint: "Correo electrónico",

              icon: Icons.email_outlined,
            ),

            const SizedBox(height: 20),

            // CONTRASEÑA
            TextFormField(
              controller: contrasenaController,

              obscureText: obscureText,

              decoration: InputDecoration(
                hintText: "Contraseña",

                prefixIcon: const Icon(Icons.lock),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },

                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),

                filled: true,

                fillColor: AppColors.inputColor,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // BOTÓN LOGIN
            SizedBox(
              width: double.infinity,

              height: 55,

              child: CustomButton(
                text: authProvider.loading ? "Cargando..." : "Ingresar",

                onPressed: () async {
                  // 1. Validar que los campos cumplan con las condiciones del Form antes de disparar la petición
                  if (formKey.currentState!.validate()) {
                    final success = await authProvider.login(
                      correoController.text.trim(),
                      contrasenaController
                          .text, // Prueba quitando el .trim() aquí si sospechas del espacio oculto
                    );

                    print("LOGIN SUCCESS: $success");

                    if (!context.mounted) return;

                    if (success) {
                      Navigator.pushReplacementNamed(context, "/dashboard");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Correo o contraseña incorrectos"),
                        ),
                      );
                    }
                  }
                },
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text("¿No tienes cuenta?"),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },

                  child: Text(
                    "Registrarse",

                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//hola 