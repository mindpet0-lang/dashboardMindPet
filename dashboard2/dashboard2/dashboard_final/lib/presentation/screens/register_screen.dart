import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

import '../providers/auth_provider.dart';

import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedRole = "USER";

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),

            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),

              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,

                borderRadius: BorderRadius.circular(30),

                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),

              child: Form(
                key: formKey,

                child: Column(
                  children: [
                    Icon(Icons.person_add, size: 70, color: AppColors.primary),

                    const SizedBox(height: 20),

                    Text("Crear Cuenta", style: AppTextStyles.heading),

                    const SizedBox(height: 30),

                    // NOMBRE
                    CustomTextField(
                      controller: nameController,

                      hint: "Nombre",

                      icon: Icons.person,
                    ),

                    const SizedBox(height: 20),

                    // CORREO
                    CustomTextField(
                      controller: emailController,

                      hint: "Correo",

                      icon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    // CONTRASEÑA
                    TextFormField(
                      controller: passwordController,

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
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
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

                    const SizedBox(height: 20),

                    // SELECTOR DE ROL
                    DropdownButtonFormField<String>(
                      value: selectedRole,

                      decoration: InputDecoration(
                        hintText: "Selecciona un rol",

                        prefixIcon: const Icon(Icons.admin_panel_settings),

                        filled: true,

                        fillColor: AppColors.inputColor,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),

                          borderSide: BorderSide.none,
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(value: "USER", child: Text("Usuario")),

                        DropdownMenuItem(
                          value: "ADMIN",

                          child: Text("Administrador"),
                        ),
                      ],

                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedRole = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    // BOTÓN
                    SizedBox(
                      width: double.infinity,

                      height: 55,

                      child: CustomButton(
                        text: authProvider.loading
                            ? "Cargando..."
                            : "Registrarse",

                        onPressed: () async {
                          final success = await authProvider.register(
                            nameController.text.trim(),

                            emailController.text.trim(),

                            passwordController.text.trim(),

                            selectedRole,
                          );

                          print("REGISTER SUCCESS:");
                          print(success);

                          if (!context.mounted) return;

                          if (success) {
                            Navigator.pushReplacementNamed(
                              context,

                              "/dashboard",
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("No se pudo registrar"),
                              ),
                            );
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,

                          AppRoutes.login,
                        );
                      },

                      child: const Text("¿Ya tienes cuenta? Inicia sesión"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//holaa