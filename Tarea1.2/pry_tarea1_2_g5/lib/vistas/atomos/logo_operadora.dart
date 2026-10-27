import 'package:flutter/material.dart';

import '../../tema/imagenes_app.dart';
import 'imagen_app.dart';

/// ÁTOMO: logo de la operadora según su nombre.
class OperadoraLogo extends StatelessWidget {
  final String nombre;
  final double alto;
  final bool circular; // versión en círculo para el comprobante (Claro)

  const OperadoraLogo({super.key, required this.nombre, this.alto = 30, this.circular = false});

  String get _ruta {
    if (nombre == 'Claro') return circular ? AppImages.claroCirculo : AppImages.claro;
    if (nombre == 'Movistar') return AppImages.movistar;
    if (nombre == 'Tuenti') return AppImages.tuenti;
    return AppImages.cnt;
  }

  @override
  Widget build(BuildContext context) {
    return AppImage(_ruta, alto: alto);
  }
}
