import 'package:flutter/material.dart';

import '../../tema/imagenes_app.dart';
import 'imagen_app.dart';

/// ÁTOMO: logo de la app (dos teléfonos con un rayo).
class AppLogo extends StatelessWidget {
  final double alto;

  const AppLogo({super.key, this.alto = 115});

  @override
  Widget build(BuildContext context) {
    return AppImage(AppImages.logo, alto: alto);
  }
}
