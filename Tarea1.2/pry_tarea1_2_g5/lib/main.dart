import 'dart:math';

import 'package:flutter/material.dart';

import 'rutas/rutas_app.dart';
import 'tema/tema_app.dart';

void main() {
  runApp(const RecargasApp());
}

class RecargasApp extends StatelessWidget {
  const RecargasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecargaFácil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema, // Tema propio
      initialRoute: AppRoutes.login, // Navegación por rutas
      routes: AppRoutes.rutas,
      // En pantallas anchas (web/PC) la app se muestra con tamaño de celular
      builder: (context, child) => MarcoCelular(child: child!),
    );
  }
}

/// Si la pantalla es ancha, muestra la app centrada con tamaño de celular.
class MarcoCelular extends StatelessWidget {
  final Widget child;

  const MarcoCelular({super.key, required this.child});

  static const double anchoCelular = 412;

  @override
  Widget build(BuildContext context) {
    final pantalla = MediaQuery.sizeOf(context);

    // En el celular se ve normal
    if (pantalla.width < 600) return child;

    final alto = min(pantalla.height - 40, 900.0);

    return ColoredBox(
      color: const Color(0xFFF8EDF1),
      child: Center(
        child: Container(
          width: anchoCelular,
          height: alto,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: const [
              BoxShadow(color: Color(0x33000000), blurRadius: 30, offset: Offset(0, 12)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: MediaQuery(
              // Las pantallas creen que están en un celular de este tamaño
              data: MediaQuery.of(context).copyWith(size: Size(anchoCelular, alto)),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
