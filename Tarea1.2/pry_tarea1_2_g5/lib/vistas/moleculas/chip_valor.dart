import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';
import '../../tema/tema_app.dart';

/// MOLÉCULA: botón seleccionable con un valor de recarga ("$ 10").
class ValorChip extends StatelessWidget {
  final String texto;
  final bool seleccionado;
  final VoidCallback onTap;

  const ValorChip({
    super.key,
    required this.texto,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: AppTheme.cajaSeleccionable(seleccionado, colorSeleccion: AppColors.rosaChip),
        child: Text(
          texto,
          style: TextStyle(
            fontSize: 15,
            fontWeight: seleccionado ? FontWeight.w600 : FontWeight.normal,
            color: seleccionado ? AppColors.vino : AppColors.texto,
          ),
        ),
      ),
    );
  }
}
