import 'modelo_operadora.dart';

/// MODELO: una recarga y sus cálculos.
class RecargaModel {
  final String numero;
  final OperadoraModel operadora;
  final double valor;
  final String formaPago;
  final DateTime fecha;

  RecargaModel({
    required this.numero,
    required this.operadora,
    required this.valor,
    required this.formaPago,
    required this.fecha,
  });

  /// El porcentaje depende de la operadora y del valor:
  /// las recargas de $20 o más pagan 0,5 % menos de comisión.
  double get porcentajeComision {
    if (valor >= 20) {
      return operadora.porcentajeComision - 0.5;
    }
    return operadora.porcentajeComision;
  }

  /// Comisión = Valor de recarga × porcentaje de comisión
  double get comision => valor * porcentajeComision / 100;

  /// Total a pagar = Valor de recarga + Comisión
  double get total => valor + comision;

  /// Ganancia = Valor de recarga × porcentaje de ganancia
  double get ganancia => valor * operadora.porcentajeGanancia / 100;

  /// Número de operación simple a partir de la hora.
  String get numeroComprobante {
    final texto = fecha.millisecondsSinceEpoch.toString();
    return texto.substring(texto.length - 7);
  }
}
