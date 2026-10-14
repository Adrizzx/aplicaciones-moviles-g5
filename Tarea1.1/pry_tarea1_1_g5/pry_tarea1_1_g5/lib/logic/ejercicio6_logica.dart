// Ejercicio 6: impuesto de los vehículos de una compañía automotriz.
// Clave 1 paga 10%, clave 2 paga 7% y clave 3 paga 5% de su valor.

class Vehiculo {
  final int clave;
  final double valor;
  final double impuesto;

  Vehiculo(this.clave, this.valor) : impuesto = valor * Ejercicio6.porcentaje(clave);
}

class Ejercicio6 {
  final List<Vehiculo> vehiculos = [];

  /// Porcentaje de impuesto según la clave del vehículo.
  static double porcentaje(int clave) {
    switch (clave) {
      case 1:
        return 0.10;
      case 2:
        return 0.07;
      case 3:
        return 0.05;
      default:
        throw ArgumentError('La clave debe ser 1, 2 o 3');
    }
  }

  Vehiculo agregar(int clave, double valor) {
    if (valor <= 0) {
      throw ArgumentError('El valor del vehículo debe ser mayor que 0');
    }
    final vehiculo = Vehiculo(clave, valor);
    vehiculos.add(vehiculo);
    return vehiculo;
  }

  int cantidadPorClave(int clave) =>
      vehiculos.where((v) => v.clave == clave).length;

  double totalPorClave(int clave) {
    double total = 0;
    for (final v in vehiculos) {
      if (v.clave == clave) total += v.impuesto;
    }
    return total;
  }

  double get totalGeneral {
    double total = 0;
    for (final v in vehiculos) {
      total += v.impuesto;
    }
    return total;
  }

  void limpiar() => vehiculos.clear();
}
