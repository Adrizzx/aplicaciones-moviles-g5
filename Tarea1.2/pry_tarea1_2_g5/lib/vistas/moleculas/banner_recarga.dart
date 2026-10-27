import 'package:flutter/material.dart';

import '../../tema/imagenes_app.dart';
import '../atomos/imagen_app.dart';

/// MOLÉCULA: banner "Selecciona los datos de tu recarga".
class RecargaBanner extends StatelessWidget {
  const RecargaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: const AppImage(AppImages.banner, fit: BoxFit.fitWidth),
    );
  }
}
