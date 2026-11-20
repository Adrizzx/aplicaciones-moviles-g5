import 'package:flutter/material.dart';

import '../../theme/colores_app.dart';

class CampoFormulario extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final Widget campo;
  final bool obligatorio;
  final double separacion;

  const CampoFormulario({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.campo,
    this.obligatorio = false,
    this.separacion = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(icono, size: 20, color: ColoresApp.verdeOscuro),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$etiqueta${obligatorio ? ' *' : ''}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
        SizedBox(height: separacion),
        campo,
      ],
    );
  }
}
