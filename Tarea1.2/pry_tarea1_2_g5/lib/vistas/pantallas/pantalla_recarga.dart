import 'package:flutter/material.dart';

import '../../controladores/controlador_recarga.dart';
import '../../rutas/rutas_app.dart';
import '../organismos/formulario_recarga.dart';

/// PANTALLA 2: Nueva recarga (pantalla principal).
class RecargaScreen extends StatelessWidget {
  const RecargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RecargaController();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 28),
        title: const Text('Nueva recarga'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, size: 28),
            tooltip: 'Cerrar sesión',
            onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: RecargaForm(
                controller: controller,
                // Se envía la recarga como argumento de la ruta
                onConfirm: (recarga) => Navigator.pushNamed(
                  context,
                  AppRoutes.comprobante,
                  arguments: recarga,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
