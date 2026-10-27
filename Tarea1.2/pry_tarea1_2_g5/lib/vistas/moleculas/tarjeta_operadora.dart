import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';
import '../../tema/tema_app.dart';
import '../atomos/logo_operadora.dart';

/// MOLÉCULA: tarjeta seleccionable con el logo y nombre de la operadora.
class OperadoraCard extends StatelessWidget {
  final String nombre;
  final bool seleccionada;
  final VoidCallback onTap;

  const OperadoraCard({
    super.key,
    required this.nombre,
    required this.seleccionada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: AppTheme.cajaSeleccionable(seleccionada),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32, child: OperadoraLogo(nombre: nombre, alto: 30)),
            const SizedBox(height: 6),
            Text(nombre, style: const TextStyle(fontSize: 13.5, color: AppColors.texto)),
          ],
        ),
      ),
    );
  }
}
