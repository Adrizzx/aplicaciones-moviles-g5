import 'package:flutter/material.dart';

/// ÁTOMO: imagen de la carpeta assets con un tamaño fijo.
class AppImage extends StatelessWidget {
  final String ruta;
  final double? ancho;
  final double? alto;
  final BoxFit fit;

  const AppImage(this.ruta, {super.key, this.ancho, this.alto, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ruta,
      width: ancho,
      height: alto,
      fit: fit,
      filterQuality: FilterQuality.high,
    );
  }
}
