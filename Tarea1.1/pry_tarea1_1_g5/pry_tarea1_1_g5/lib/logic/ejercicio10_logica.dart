// Ejercicio 10: números dentro y fuera de un intervalo abierto.
// Se ingresan números hasta escribir 0. Al final se muestra la suma de
// los que están dentro del intervalo, cuántos quedaron fuera y si se
// ingresó algún número igual a los límites.

class Intervalo {
  final double inferior;
  final double superior;

  final List<double> numeros = [];
  double sumaDentro = 0;
  int cantidadFuera = 0;
  bool hayIgualALimite = false;
  bool terminado = false;

  Intervalo(this.inferior, this.superior) {
    if (inferior >= superior) {
      throw ArgumentError(
          'El límite inferior debe ser menor que el límite superior');
    }
  }

  /// Agrega un número. Si es 0 se termina el ingreso de datos.
  void agregar(double numero) {
    if (terminado) {
      throw StateError('Ya se ingresó el 0, el ingreso terminó');
    }
    if (numero == 0) {
      terminado = true;
      return;
    }

    numeros.add(numero);

    if (numero > inferior && numero < superior) {
      sumaDentro += numero;
    } else if (numero == inferior || numero == superior) {
      // En un intervalo abierto los límites no están dentro,
      // pero se avisan aparte como pide el enunciado.
      hayIgualALimite = true;
    } else {
      cantidadFuera++;
    }
  }
}
