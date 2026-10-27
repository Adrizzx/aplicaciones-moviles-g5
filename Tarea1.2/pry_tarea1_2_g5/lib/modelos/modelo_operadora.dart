/// MODELO: una operadora con sus porcentajes.
class OperadoraModel {
  final String nombre;
  final double porcentajeComision; // lo que paga el cliente
  final double porcentajeGanancia; // lo que gana el local

  const OperadoraModel({
    required this.nombre,
    required this.porcentajeComision,
    required this.porcentajeGanancia,
  });
}
