import 'package:flutter/material.dart';

import 'rutas.dart';
import 'screens/ejercicio10_screen.dart';
import 'screens/ejercicio6_screen.dart';
import 'screens/ejercicio7_screen.dart';
import 'screens/ejercicio8_screen.dart';
import 'screens/ejercicio9_screen.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 1.1 - Grupo 5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      // Pantalla con la que arranca la app
      initialRoute: Rutas.menu,
      // Tabla de rutas: cada nombre abre una pantalla
      routes: {
        Rutas.menu: (context) => const MenuScreen(),
        Rutas.ejercicio6: (context) => const Ejercicio6Screen(),
        Rutas.ejercicio7: (context) => const Ejercicio7Screen(),
        Rutas.ejercicio8: (context) => const Ejercicio8Screen(),
        Rutas.ejercicio9: (context) => const Ejercicio9Screen(),
        Rutas.ejercicio10: (context) => const Ejercicio10Screen(),
      },
    );
  }
}
