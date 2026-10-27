import 'package:flutter/material.dart';

/// ÁTOMO: botón en forma de píldora con ícono.
class AppButton extends StatelessWidget {
  final String texto;
  final IconData icono;
  final VoidCallback onPressed;
  final Color? color;
  final Color? colorTexto;
  final bool iconoAlFinal;
  final double alto;
  final TextStyle? estiloTexto;

  const AppButton({
    super.key,
    required this.texto,
    required this.icono,
    required this.onPressed,
    this.color,
    this.colorTexto,
    this.iconoAlFinal = false,
    this.alto = 48,
    this.estiloTexto,
  });

  @override
  Widget build(BuildContext context) {
    final contenido = iconoAlFinal
        ? [Text(texto, style: estiloTexto), const SizedBox(width: 12), Icon(icono, size: 20)]
        : [Icon(icono, size: 20), const SizedBox(width: 10), Text(texto, style: estiloTexto)];

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: colorTexto,
        minimumSize: Size(double.infinity, alto),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: contenido),
    );
  }
}
