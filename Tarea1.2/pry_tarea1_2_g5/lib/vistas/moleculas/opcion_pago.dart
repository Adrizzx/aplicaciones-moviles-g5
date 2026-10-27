import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';
import '../../tema/tema_app.dart';

/// MOLÉCULA: fila seleccionable de forma de pago (ícono + texto + radio).
class PagoOption extends StatelessWidget {
  final String texto;
  final IconData icono;
  final bool seleccionada;
  final VoidCallback onTap;

  const PagoOption({
    super.key,
    required this.texto,
    required this.icono,
    required this.seleccionada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: AppTheme.cajaSeleccionable(seleccionada),
        child: Row(
          children: [
            Icon(icono, color: AppColors.texto, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(texto, style: const TextStyle(fontSize: 13.5))),
            // Círculo de selección
            Container(
              width: 16,
              height: 16,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: seleccionada ? AppColors.vino : const Color(0xFFC9C3C6),
                  width: 1.4,
                ),
              ),
              child: seleccionada
                  ? const DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.vino, shape: BoxShape.circle),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
