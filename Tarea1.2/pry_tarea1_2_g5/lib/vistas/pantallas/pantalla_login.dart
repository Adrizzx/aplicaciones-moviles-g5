import 'package:flutter/material.dart';

import '../../controladores/controlador_login.dart';
import '../../rutas/rutas_app.dart';
import '../../tema/colores_app.dart';
import '../../tema/imagenes_app.dart';
import '../atomos/imagen_app.dart';
import '../moleculas/encabezado.dart';
import '../organismos/formulario_login.dart';

/// PANTALLA 1: Inicio de sesión.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();

    void mostrarMensaje(String texto, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(texto), backgroundColor: color),
      );
    }

    void ingresar(String usuario, String contrasena) {
      if (controller.iniciarSesion(usuario, contrasena)) {
        Navigator.pushReplacementNamed(context, AppRoutes.recarga);
      } else {
        mostrarMensaje('Usuario o contraseña incorrectos', AppColors.error);
      }
    }

    return Scaffold(
      body: Container(
        // Fondo verde oscuro como la plantilla
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF183536), Color(0xFF062223), Color(0xFF0B2122), Color(0xFF23272A)],
            stops: [0.0, 0.45, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Onda rosada con "Recargas más cerca de ti"
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AppImage(AppImages.ondaLogin, fit: BoxFit.fitWidth),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 220),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      children: [
                        const Encabezado(),
                        const SizedBox(height: 56),
                        LoginForm(
                          controller: controller,
                          onLogin: ingresar,
                          onForgotPassword: () => mostrarMensaje(
                            'Usuario de prueba: admin  /  Contraseña: 1234',
                            AppColors.vino,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
