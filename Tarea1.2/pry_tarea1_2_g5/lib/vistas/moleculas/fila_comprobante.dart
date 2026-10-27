import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';

/// MOLÉCULA: ícono + etiqueta pequeña + valor grande (comprobante).
class ComprobanteItem extends StatelessWidget {
  final Widget icono;
  final String etiqueta;
  final String valor;

  const ComprobanteItem({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          SizedBox(width: 42, height: 42, child: icono),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(etiqueta, style: const TextStyle(fontSize: 13.5, color: AppColors.textoSuave)),
                const SizedBox(height: 2),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.texto,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
