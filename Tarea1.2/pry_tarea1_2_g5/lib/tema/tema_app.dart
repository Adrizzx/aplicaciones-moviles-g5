import 'package:flutter/material.dart';

import 'colores_app.dart';

/// Tema propio: colores, tipografía, botones y campos de entrada.
class AppTheme {
  // Tipografías (están en assets/fonts)
  static const String fuenteTitulos = 'Lora';
  static const String fuenteLogo = 'Poppins';

  static ThemeData get tema {
    final borde = BorderRadius.circular(10);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.vino,
        primary: AppColors.vino,
        secondary: AppColors.verdeOscuro,
        error: AppColors.error,
        surface: AppColors.fondo,
      ),
      scaffoldBackgroundColor: AppColors.fondo,

      // Tipografía
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: fuenteTitulos,
          fontSize: 22,
          color: AppColors.texto,
        ),
        titleMedium: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w600,
          color: AppColors.texto,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.texto),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textoSuave),
      ),

      // Barra superior
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.fondo,
        foregroundColor: AppColors.texto,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fuenteTitulos,
          fontSize: 22,
          color: AppColors.texto,
        ),
      ),

      // Botones en forma de píldora
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vino,
          foregroundColor: AppColors.blanco,
          minimumSize: const Size(double.infinity, 48),
          shape: const StadiumBorder(),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.rosa),
      ),

      // Campos de entrada
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.blanco,
        hintStyle: const TextStyle(color: AppColors.textoSuave, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.textoSuave, fontSize: 13),
        prefixIconColor: AppColors.texto,
        suffixIconColor: AppColors.texto,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(borderRadius: borde),
        enabledBorder: OutlineInputBorder(
          borderRadius: borde,
          borderSide: const BorderSide(color: AppColors.borde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borde,
          borderSide: const BorderSide(color: AppColors.bordeRosa, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borde,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borde,
          borderSide: const BorderSide(color: AppColors.error, width: 1.4),
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.fondo,
        selectedItemColor: AppColors.vino,
        unselectedItemColor: Color(0xFF5B6670),
        selectedLabelStyle: TextStyle(fontSize: 11),
        unselectedLabelStyle: TextStyle(fontSize: 11),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }

  /// Estilo de las cajas seleccionables (operadora, valor, forma de pago).
  static BoxDecoration cajaSeleccionable(bool seleccionada, {Color? colorSeleccion}) {
    return BoxDecoration(
      color: seleccionada ? (colorSeleccion ?? AppColors.rosaSuave) : AppColors.blanco,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: seleccionada ? AppColors.bordeRosa : AppColors.borde,
        width: seleccionada ? 1.4 : 1,
      ),
    );
  }
}
