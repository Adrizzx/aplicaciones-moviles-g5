// Ejercicio 8: ahorro de una persona durante un año.
// Cada mes deposita una cantidad distinta y se quiere saber
// cuánto lleva ahorrado cada mes y el total del año.

class Ejercicio8 {
  static const List<String> meses = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];

  /// Recibe los 12 depósitos y devuelve el ahorro acumulado mes a mes.
  static List<double> calcularAcumulado(List<double> depositos) {
    if (depositos.length != 12) {
      throw ArgumentError('Se necesitan los depósitos de los 12 meses');
    }
    final acumulado = <double>[];
    double suma = 0;
    for (final deposito in depositos) {
      if (deposito < 0) {
        throw ArgumentError('Los depósitos no pueden ser negativos');
      }
      suma += deposito;
      acumulado.add(suma);
    }
    return acumulado;
  }

  /// Total ahorrado en el año.
  static double totalAnual(List<double> depositos) =>
      calcularAcumulado(depositos).last;
}
