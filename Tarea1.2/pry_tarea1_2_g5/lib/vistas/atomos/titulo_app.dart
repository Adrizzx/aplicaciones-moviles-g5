import 'package:flutter/material.dart';

import '../../tema/tema_app.dart';

/// ÁTOMO: título con la tipografía Lora.
class AppTitle extends StatelessWidget {
  final String texto;
  final Color? color;
  final double tamano;
  final TextAlign alineacion;

  const AppTitle(
    this.texto, {
    super.key,
    this.color,
    this.tamano = 22,
    this.alineacion = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: alineacion,
      style: TextStyle(
        fontFamily: AppTheme.fuenteTitulos,
        fontSize: tamano,
        color: color ?? Theme.of(context).textTheme.headlineSmall?.color,
      ),
    );
  }
}
