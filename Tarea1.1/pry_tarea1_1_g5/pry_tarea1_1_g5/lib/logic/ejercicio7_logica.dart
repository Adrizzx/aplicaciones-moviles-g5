// Ejercicio 7: banco "Bandido de peluche".
// Para cada cliente se calcula su saldo actual, el pago mínimo (15%)
// y el pago para no generar intereses (85%). Si el cliente no cubrió
// el pago mínimo del corte anterior (15% del saldo anterior) se le
// cobra 12% de interés sobre lo que quedó debiendo y $200 de multa.

class Cliente {
  final String nombre;
  final double saldoAnterior;
  final double compras;
  final double pagoRealizado;

  late final double pagoMinimoAnterior;
  late final bool esMoroso;
  late final double intereses;
  late final double multa;
  late final double saldoActual;
  late final double pagoMinimo;
  late final double pagoSinIntereses;

  Cliente({
    required this.nombre,
    required this.saldoAnterior,
    required this.compras,
    required this.pagoRealizado,
  }) {
    pagoMinimoAnterior = saldoAnterior * Ejercicio7.porcentajePagoMinimo;
    esMoroso = pagoRealizado < pagoMinimoAnterior;

    if (esMoroso) {
      intereses = (saldoAnterior - pagoRealizado) * Ejercicio7.porcentajeInteres;
      multa = Ejercicio7.multa;
    } else {
      intereses = 0;
      multa = 0;
    }

    saldoActual = saldoAnterior - pagoRealizado + compras + intereses + multa;
    pagoMinimo = saldoActual * Ejercicio7.porcentajePagoMinimo;
    pagoSinIntereses = saldoActual * Ejercicio7.porcentajeSinIntereses;
  }
}

class Ejercicio7 {
  static const double porcentajePagoMinimo = 0.15;
  static const double porcentajeSinIntereses = 0.85;
  static const double porcentajeInteres = 0.12;
  static const double multa = 200;

  final List<Cliente> clientes = [];

  Cliente agregarCliente({
    required String nombre,
    required double saldoAnterior,
    required double compras,
    required double pagoRealizado,
  }) {
    if (nombre.trim().isEmpty) {
      throw ArgumentError('Ingrese el nombre del cliente');
    }
    if (saldoAnterior < 0 || compras < 0 || pagoRealizado < 0) {
      throw ArgumentError('No se permiten valores negativos');
    }
    if (pagoRealizado > saldoAnterior + compras) {
      throw ArgumentError(
          'El pago no puede ser mayor que el saldo anterior más las compras');
    }
    final cliente = Cliente(
      nombre: nombre.trim(),
      saldoAnterior: saldoAnterior,
      compras: compras,
      pagoRealizado: pagoRealizado,
    );
    clientes.add(cliente);
    return cliente;
  }

  int get cantidadMorosos => clientes.where((c) => c.esMoroso).length;

  /// Lo que gana el banco por intereses de los clientes morosos.
  double get gananciaIntereses {
    double total = 0;
    for (final c in clientes) {
      total += c.intereses;
    }
    return total;
  }

  double get totalMultas {
    double total = 0;
    for (final c in clientes) {
      total += c.multa;
    }
    return total;
  }

  void limpiar() => clientes.clear();
}
