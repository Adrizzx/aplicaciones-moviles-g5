import 'package:flutter_test/flutter_test.dart';
import 'package:deber2/modelos/modelo_operadora.dart';
import 'package:deber2/modelos/modelo_recarga.dart';

void main() {
  const claro = OperadoraModel(nombre: 'Claro', porcentajeComision: 3, porcentajeGanancia: 2);

  test('Recarga de \$10 en Claro: comisión \$0,30, total \$10,30, ganancia \$0,20', () {
    final recarga = RecargaModel(
      numero: '0987654321',
      operadora: claro,
      valor: 10,
      formaPago: 'Efectivo',
      fecha: DateTime(2026, 10, 26),
    );

    expect(recarga.comision, closeTo(0.30, 0.001));
    expect(recarga.total, closeTo(10.30, 0.001));
    expect(recarga.ganancia, closeTo(0.20, 0.001));
  });

  test('Recarga de \$20 o más paga 0,5 % menos de comisión', () {
    final recarga = RecargaModel(
      numero: '0987654321',
      operadora: claro,
      valor: 20,
      formaPago: 'Efectivo',
      fecha: DateTime(2026, 10, 26),
    );

    expect(recarga.porcentajeComision, 2.5);
    expect(recarga.comision, closeTo(0.50, 0.001));
  });
}
