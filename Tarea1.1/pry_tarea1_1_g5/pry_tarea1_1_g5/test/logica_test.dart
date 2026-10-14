// Pruebas unitarias de la lógica de los ejercicios 6 al 10.
// Se ejecutan con: flutter test

import 'package:flutter_test/flutter_test.dart';
import 'package:pry_tarea1_1_g5/logic/ejercicio10_logica.dart';
import 'package:pry_tarea1_1_g5/logic/ejercicio6_logica.dart';
import 'package:pry_tarea1_1_g5/logic/ejercicio7_logica.dart';
import 'package:pry_tarea1_1_g5/logic/ejercicio8_logica.dart';
import 'package:pry_tarea1_1_g5/logic/ejercicio9_logica.dart';
import 'package:pry_tarea1_1_g5/utils/validaciones.dart';

void main() {
  group('Validaciones', () {
    test('lee decimales con punto o coma', () {
      expect(leerDecimal('12.5'), 12.5);
      expect(leerDecimal('12,5'), 12.5);
      expect(leerDecimal('abc'), isNull);
      expect(leerDecimal(''), isNull);
    });

    test('rechaza vacíos, letras y negativos', () {
      expect(validarNoNegativo(''), isNotNull);
      expect(validarNoNegativo('hola'), isNotNull);
      expect(validarNoNegativo('-5'), isNotNull);
      expect(validarNoNegativo('0'), isNull);
      expect(validarPositivo('0'), isNotNull);
      expect(validarPositivo('100'), isNull);
    });
  });

  group('Ejercicio 6 - Impuesto de vehículos', () {
    test('calcula el impuesto por clave y los totales', () {
      final e = Ejercicio6();
      e.agregar(1, 10000); // 10% = 1000
      e.agregar(2, 20000); // 7%  = 1400
      e.agregar(3, 30000); // 5%  = 1500
      e.agregar(1, 5000); //  10% = 500

      expect(e.vehiculos[0].impuesto, closeTo(1000, 0.001));
      expect(e.totalPorClave(1), closeTo(1500, 0.001));
      expect(e.totalPorClave(2), closeTo(1400, 0.001));
      expect(e.totalPorClave(3), closeTo(1500, 0.001));
      expect(e.cantidadPorClave(1), 2);
      expect(e.totalGeneral, closeTo(4400, 0.001));
    });

    test('rechaza clave inválida y valor menor o igual a 0', () {
      final e = Ejercicio6();
      expect(() => e.agregar(4, 1000), throwsArgumentError);
      expect(() => e.agregar(1, 0), throwsArgumentError);
    });
  });

  group('Ejercicio 7 - Banco', () {
    test('cliente al día: sin intereses ni multa', () {
      final e = Ejercicio7();
      final c = e.agregarCliente(
          nombre: 'Ana', saldoAnterior: 1000, compras: 500, pagoRealizado: 200);

      expect(c.esMoroso, isFalse);
      expect(c.saldoActual, closeTo(1300, 0.001));
      expect(c.pagoMinimo, closeTo(195, 0.001));
      expect(c.pagoSinIntereses, closeTo(1105, 0.001));
    });

    test('cliente moroso: 12% de interés y \$200 de multa', () {
      final e = Ejercicio7();
      // Pago mínimo anterior = 150, pagó 100 -> moroso
      final c = e.agregarCliente(
          nombre: 'Luis', saldoAnterior: 1000, compras: 300, pagoRealizado: 100);

      expect(c.esMoroso, isTrue);
      expect(c.intereses, closeTo(108, 0.001)); // 12% de 900
      expect(c.multa, 200);
      expect(c.saldoActual, closeTo(1508, 0.001)); // 900 + 300 + 108 + 200
      expect(c.pagoMinimo, closeTo(226.2, 0.001));
      expect(c.pagoSinIntereses, closeTo(1281.8, 0.001));
      expect(e.gananciaIntereses, closeTo(108, 0.001));
      expect(e.cantidadMorosos, 1);
    });

    test('rechaza datos inválidos', () {
      final e = Ejercicio7();
      expect(
          () => e.agregarCliente(
              nombre: '', saldoAnterior: 10, compras: 0, pagoRealizado: 0),
          throwsArgumentError);
      expect(
          () => e.agregarCliente(
              nombre: 'X', saldoAnterior: 100, compras: 0, pagoRealizado: 500),
          throwsArgumentError);
    });
  });

  group('Ejercicio 8 - Ahorro anual', () {
    test('calcula el acumulado de cada mes y el total', () {
      final depositos = List<double>.generate(12, (i) => (i + 1) * 10.0);
      final acumulado = Ejercicio8.calcularAcumulado(depositos);

      expect(acumulado[0], 10);
      expect(acumulado[1], 30);
      expect(acumulado[11], 780);
      expect(Ejercicio8.totalAnual(depositos), 780);
    });

    test('rechaza menos de 12 meses o depósitos negativos', () {
      expect(() => Ejercicio8.calcularAcumulado([100]), throwsArgumentError);
      final conNegativo = List<double>.filled(12, 50)..[3] = -1;
      expect(() => Ejercicio8.calcularAcumulado(conNegativo),
          throwsArgumentError);
    });
  });

  group('Ejercicio 9 - Adivina el número', () {
    test('da pistas y termina al acertar', () {
      final juego = JuegoAdivinar(numeroSecreto: 42);

      expect(juego.intentar(50).pista, Pista.menor);
      expect(juego.intentar(30).pista, Pista.mayor);
      final r = juego.intentar(42);

      expect(r.pista, Pista.acierto);
      expect(juego.intentosUsados, 3);
      expect(juego.gano, isTrue);
      expect(juego.terminado, isTrue);
    });

    test('termina al agotar los 10 intentos', () {
      final juego = JuegoAdivinar(numeroSecreto: 100);
      for (int i = 1; i <= 10; i++) {
        juego.intentar(i);
      }
      expect(juego.terminado, isTrue);
      expect(juego.gano, isFalse);
      expect(juego.intentosRestantes, 0);
      expect(() => juego.intentar(100), throwsStateError);
    });

    test('rechaza números fuera de 1 a 100', () {
      final juego = JuegoAdivinar(numeroSecreto: 10);
      expect(() => juego.intentar(0), throwsArgumentError);
      expect(() => juego.intentar(101), throwsArgumentError);
      expect(juego.intentosUsados, 0);
    });

    test('el número aleatorio siempre está entre 1 y 100', () {
      for (int i = 0; i < 500; i++) {
        final n = JuegoAdivinar().numeroSecreto;
        expect(n >= 1 && n <= 100, isTrue);
      }
    });
  });

  group('Ejercicio 10 - Intervalo', () {
    test('suma los de adentro, cuenta los de afuera y detecta límites', () {
      final intervalo = Intervalo(10, 20);
      for (final n in [15.0, 12.0, 25.0, 5.0, 10.0, 0.0]) {
        intervalo.agregar(n);
      }

      expect(intervalo.sumaDentro, 27); // 15 + 12
      expect(intervalo.cantidadFuera, 2); // 25 y 5
      expect(intervalo.hayIgualALimite, isTrue); // 10
      expect(intervalo.terminado, isTrue);
    });

    test('vuelve a pedir si el inferior es mayor que el superior', () {
      expect(() => Intervalo(20, 10), throwsArgumentError);
    });

    test('no permite agregar después del 0', () {
      final intervalo = Intervalo(1, 5)..agregar(0);
      expect(() => intervalo.agregar(3), throwsStateError);
    });
  });
}
