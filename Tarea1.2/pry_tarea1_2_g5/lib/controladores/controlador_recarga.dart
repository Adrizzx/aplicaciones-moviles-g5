import '../modelos/modelo_operadora.dart';
import '../modelos/modelo_recarga.dart';

/// CONTROLADOR: datos de las opciones, validaciones y creación de la recarga.
class RecargaController {
  // Cada operadora tiene porcentajes diferentes
  final List<OperadoraModel> operadoras = const [
    OperadoraModel(nombre: 'Claro', porcentajeComision: 3, porcentajeGanancia: 2),
    OperadoraModel(nombre: 'Movistar', porcentajeComision: 2.5, porcentajeGanancia: 2),
    OperadoraModel(nombre: 'Tuenti', porcentajeComision: 3.5, porcentajeGanancia: 2.5),
    OperadoraModel(nombre: 'Cnt', porcentajeComision: 2, porcentajeGanancia: 1.5),
  ];

  final List<double> valores = const [5, 10, 15, 20];

  final List<String> formasPago = const [
    'Tarjeta de crédito / débito',
    'Transferencia bancaria',
    'Efectivo',
  ];

  /// El número debe tener 10 dígitos y empezar con 09.
  String? validarNumero(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Ingrese el número telefónico';
    }
    if (!RegExp(r'^09\d{8}$').hasMatch(valor.trim())) {
      return 'Debe tener 10 dígitos y empezar con 09';
    }
    return null;
  }

  String? validarSeleccion(Object? valor, String campo) {
    if (valor == null) {
      return 'Seleccione $campo';
    }
    return null;
  }

  /// Usa el valor elegido en los botones o, si no hay, el escrito en "Otro valor".
  double? obtenerValor(double? valorElegido, String otroValor) {
    if (valorElegido != null) return valorElegido;
    return double.tryParse(otroValor.trim());
  }

  String? validarValor(double? valorElegido, String otroValor) {
    if (valorElegido != null) return null;
    if (otroValor.trim().isEmpty) {
      return 'Seleccione o ingrese un valor';
    }
    final valor = double.tryParse(otroValor.trim());
    if (valor == null) {
      return 'Ingrese un valor válido';
    }
    if (valor < 1 || valor > 100) {
      return 'El valor debe estar entre \$1 y \$100';
    }
    return null;
  }

  RecargaModel crearRecarga({
    required String numero,
    required OperadoraModel operadora,
    required double valor,
    required String formaPago,
  }) {
    return RecargaModel(
      numero: numero.trim(),
      operadora: operadora,
      valor: valor,
      formaPago: formaPago,
      fecha: DateTime.now(),
    );
  }
}
