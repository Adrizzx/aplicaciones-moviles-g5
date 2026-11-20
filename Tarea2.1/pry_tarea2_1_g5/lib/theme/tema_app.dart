import 'package:flutter/material.dart';
import 'colores_app.dart';

class TemaApp {
  static ThemeData get claro {
    final colores = ColorScheme.fromSeed(seedColor: ColoresApp.verdeOscuro)
        .copyWith(primary: ColoresApp.verdePrincipal,
          onPrimary: ColoresApp.blanco, surface: ColoresApp.blanco,
          onSurface: ColoresApp.textoPrincipal);
    final bordes = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    return ThemeData(
      useMaterial3: true,
      colorScheme: colores,
      scaffoldBackgroundColor: ColoresApp.fondoClaro,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColoresApp.verdeOscuro,
        foregroundColor: ColoresApp.blanco),
      cardTheme: CardThemeData(color: ColoresApp.blanco, elevation: 1,
        shape: bordes),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColoresApp.blanco,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColoresApp.verdePrincipal,
          foregroundColor: ColoresApp.blanco,
          minimumSize: const Size(0, 48), shape: bordes)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColoresApp.verdeOscuro,
          minimumSize: const Size(0, 48), shape: bordes)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ColoresApp.verdeOscuro)),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: ColoresApp.textoPrincipal,
        displayColor: ColoresApp.textoPrincipal),
    );
  }
}
