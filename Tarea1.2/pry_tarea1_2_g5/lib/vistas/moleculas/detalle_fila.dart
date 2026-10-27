import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';

/// MOLÉCULA: una fila "etiqueta ........ valor", con ícono opcional.
class DetalleFila extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final IconData? icono;
  final bool destacado;
  final bool negrita;

  const DetalleFila({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.icono,
    this.destacado = false,
    this.negrita = false,
  });

  @override
  Widget build(BuildContext context) {
    final peso = destacado || negrita ? FontWeight.w600 : FontWeight.normal;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: icono != null ? 7 : 4),
      child: Row(
        children: [
          if (icono != null) ...[
            Icon(icono, size: 19, color: const Color(0xFF4A5560)),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              etiqueta,
              style: TextStyle(
                fontSize: destacado ? 15 : 13,
                fontWeight: peso,
                color: icono != null ? const Color(0xFF4A5560) : AppColors.texto,
              ),
            ),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: destacado ? 18 : 13,
                fontWeight: destacado ? FontWeight.bold : (negrita ? FontWeight.w600 : FontWeight.normal),
                color: icono != null ? const Color(0xFF4A5560) : AppColors.texto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
