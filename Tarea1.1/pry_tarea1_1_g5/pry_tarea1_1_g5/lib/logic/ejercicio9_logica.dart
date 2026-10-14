// Ejercicio 9: adivinar un número del 1 al 100 en máximo 10 intentos.

import 'dart:math';

enum Pista { mayor, menor, acierto }

class ResultadoIntento {
  final int numero;
  final Pista pista;
  final int intentosRestantes;

  ResultadoIntento(this.numero, this.pista, this.intentosRestantes);
}

class JuegoAdivinar {
  static const int minimo = 1;
  static const int maximo = 100;
  static const int maxIntentos = 10;

  final int numeroSecreto;
  int intentosUsados = 0;
  bool gano = false;

  /// Se puede pasar el número secreto solo para hacer pruebas.
  JuegoAdivinar({int? numeroSecreto, Random? random})
      : numeroSecreto =
            numeroSecreto ?? (random ?? Random()).nextInt(maximo) + minimo;

  int get intentosRestantes => maxIntentos - intentosUsados;

  bool get terminado => gano || intentosUsados >= maxIntentos;

  ResultadoIntento intentar(int numero) {
    if (terminado) {
      throw StateError('El juego ya terminó');
    }
    if (numero < minimo || numero > maximo) {
      throw ArgumentError('El número debe estar entre $minimo y $maximo');
    }

    intentosUsados++;

    Pista pista;
    if (numero == numeroSecreto) {
      gano = true;
      pista = Pista.acierto;
    } else if (numeroSecreto > numero) {
      pista = Pista.mayor;
    } else {
      pista = Pista.menor;
    }
    return ResultadoIntento(numero, pista, intentosRestantes);
  }
}
