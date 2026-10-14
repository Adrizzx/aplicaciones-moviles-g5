// Prueba de navegación: el menú abre una pantalla y se puede regresar.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_tarea1_1_g5/main.dart';

void main() {
  testWidgets('El menú muestra los 5 ejercicios y navega', (tester) async {
    await tester.pumpWidget(const MiApp());

    expect(find.text('Menú principal'), findsOneWidget);
    for (int i = 6; i <= 10; i++) {
      expect(find.text('Ejercicio $i'), findsOneWidget);
    }

    // Abrir el ejercicio 9 y volver al menú
    await tester.tap(find.text('Ejercicio 9'));
    await tester.pumpAndSettle();
    expect(find.text('Ejercicio 9: Adivina el número'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Menú principal'), findsOneWidget);
  });
}
