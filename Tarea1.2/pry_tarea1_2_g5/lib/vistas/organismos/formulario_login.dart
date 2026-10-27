import 'package:flutter/material.dart';

import '../../controladores/controlador_login.dart';
import '../../tema/colores_app.dart';
import '../../tema/tema_app.dart';
import '../atomos/boton_app.dart';
import '../atomos/campo_texto.dart';
import '../atomos/titulo_app.dart';

/// ORGANISMO: tarjeta oscura con el formulario de inicio de sesión.
class LoginForm extends StatefulWidget {
  final LoginController controller;
  final void Function(String usuario, String contrasena) onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.controller,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();

  @override
  void dispose() {
    _usuarioCtrl.dispose();
    _contrasenaCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    // Solo continúa si todas las validaciones pasan
    if (_formKey.currentState!.validate()) {
      widget.onLogin(_usuarioCtrl.text, _contrasenaCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 16),
      decoration: BoxDecoration(
        color: const Color(0x330A1C1D),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x40FFFFFF)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AppTitle('Iniciar sesión', color: Colors.white, tamano: 32),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Ingresa tus datos para continuar',
                style: TextStyle(
                  fontFamily: AppTheme.fuenteTitulos,
                  color: Color(0xFFDCE3E2),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 26),
            AppTextField(
              hint: 'Usuario',
              icono: Icons.person_outline,
              controller: _usuarioCtrl,
              validator: widget.controller.validarUsuario,
              oscuro: true,
            ),
            const SizedBox(height: 18),
            AppTextField(
              hint: 'Contraseña',
              icono: Icons.lock,
              controller: _contrasenaCtrl,
              validator: widget.controller.validarContrasena,
              esContrasena: true,
              oscuro: true,
            ),
            const SizedBox(height: 30),
            AppButton(
              texto: 'Iniciar sesión',
              icono: Icons.arrow_forward,
              iconoAlFinal: true,
              alto: 58,
              color: AppColors.rosa,
              colorTexto: const Color(0xFF1B2B2A),
              estiloTexto: const TextStyle(
                fontFamily: AppTheme.fuenteTitulos,
                fontSize: 18,
                fontVariations: [FontVariation('wght', 600)],
              ),
              onPressed: _enviar,
            ),
            const SizedBox(height: 14),
            Center(
              child: TextButton(
                onPressed: widget.onForgotPassword,
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.rosa,
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
