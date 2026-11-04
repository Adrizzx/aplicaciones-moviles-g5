import 'package:flutter/material.dart';

// Colores suaves y tipos de letra de toda la app.
class Tema {
  static const Color crema = Color(0xFFFFFBF2);
  static const Color menta = Color(0xFFDDF1E7);
  static const Color mentaMedia = Color(0xFFBFE5D4);
  static const Color durazno = Color(0xFFFDE9D9);
  static const Color verde = Color(0xFF2A8374);
  static const Color verdeOscuro = Color(0xFF1F5F55);
  static const Color texto = Color(0xFF4A5B56);

  static const String letraTitulos = 'Fredoka';
  static const String letraTextos = 'Quicksand';
  static const String letraLogo = 'CaveatBrush';

  static const LinearGradient fondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [crema, menta],
  );

  static const LinearGradient encabezado = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [menta, mentaMedia],
  );

  static const TextStyle logo = TextStyle(
    fontFamily: letraLogo,
    color: verdeOscuro,
  );

  static const TextStyle titulo = TextStyle(
    fontFamily: letraTitulos,
    fontWeight: FontWeight.w600,
    color: verdeOscuro,
  );
}
