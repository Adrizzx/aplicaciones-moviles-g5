import 'package:flutter/material.dart';

import '../logic/ejercicio7_logica.dart';
import '../utils/validaciones.dart';
import '../widgets/comunes.dart';

class Ejercicio7Screen extends StatefulWidget {
  const Ejercicio7Screen({super.key});

  @override
  State<Ejercicio7Screen> createState() => _Ejercicio7ScreenState();
}

class _Ejercicio7ScreenState extends State<Ejercicio7Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _saldoController = TextEditingController();
  final _comprasController = TextEditingController();
  final _pagoController = TextEditingController();
  final _logica = Ejercicio7();

  @override
  void dispose() {
    _nombreController.dispose();
    _saldoController.dispose();
    _comprasController.dispose();
    _pagoController.dispose();
    super.dispose();
  }

  void _agregar() {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        _logica.agregarCliente(
          nombre: _nombreController.text,
          saldoAnterior: leerDecimal(_saldoController.text)!,
          compras: leerDecimal(_comprasController.text)!,
          pagoRealizado: leerDecimal(_pagoController.text)!,
        );
      });
    } on ArgumentError catch (e) {
      mostrarMensaje(context, e.message.toString());
      return;
    }

    _nombreController.clear();
    _saldoController.clear();
    _comprasController.clear();
    _pagoController.clear();
    FocusScope.of(context).unfocus();
    mostrarMensaje(context, 'Cliente agregado');
  }

  Widget _campo(TextEditingController controller, String etiqueta,
      String? Function(String?) validador,
      {bool esNumero = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: esNumero
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.name,
        decoration: InputDecoration(
          labelText: etiqueta,
          border: const OutlineInputBorder(),
        ),
        validator: validador,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientes = _logica.clientes;

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 7: Banco')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese los datos de cada cliente. Si el pago fue menor al 15% '
              'del saldo anterior, se cobra 12% de interés sobre lo que quedó '
              'debiendo y \$200 de multa.',
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _campo(_nombreController, 'Nombre del cliente',
                      validarTextoObligatorio,
                      esNumero: false),
                  _campo(_saldoController, 'Saldo anterior (\$)',
                      validarNoNegativo),
                  _campo(_comprasController, 'Monto de compras (\$)',
                      validarNoNegativo),
                  _campo(_pagoController, 'Pago realizado en el corte anterior (\$)',
                      validarNoNegativo),
                  ElevatedButton.icon(
                    onPressed: _agregar,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Agregar cliente'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (clientes.isEmpty)
              const Text('Aún no se han agregado clientes.')
            else ...[
              for (final c in clientes)
                TarjetaResultado(
                  titulo: c.nombre,
                  lineas: [
                    'Moroso: ${c.esMoroso ? 'Sí' : 'No'}',
                    'Intereses (12%): ${formatoDinero(c.intereses)}',
                    'Multa: ${formatoDinero(c.multa)}',
                    'Saldo actual: ${formatoDinero(c.saldoActual)}',
                    'Pago mínimo (15%): ${formatoDinero(c.pagoMinimo)}',
                    'Pago para no generar intereses (85%): '
                        '${formatoDinero(c.pagoSinIntereses)}',
                  ],
                ),
              TarjetaResultado(
                titulo: 'Resumen del banco',
                lineas: [
                  'Clientes registrados: ${clientes.length}',
                  'Clientes morosos: ${_logica.cantidadMorosos}',
                  'Ganancia por intereses: '
                      '${formatoDinero(_logica.gananciaIntereses)}',
                  'Total cobrado en multas: '
                      '${formatoDinero(_logica.totalMultas)}',
                ],
              ),
              TextButton(
                onPressed: () => setState(_logica.limpiar),
                child: const Text('Limpiar lista'),
              ),
            ],
            const SizedBox(height: 8),
            const BotonVolver(),
          ],
        ),
      ),
    );
  }
}
