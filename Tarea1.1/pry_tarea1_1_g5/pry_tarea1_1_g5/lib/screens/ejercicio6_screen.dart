import 'package:flutter/material.dart';

import '../logic/ejercicio6_logica.dart';
import '../utils/validaciones.dart';
import '../widgets/comunes.dart';

class Ejercicio6Screen extends StatefulWidget {
  const Ejercicio6Screen({super.key});

  @override
  State<Ejercicio6Screen> createState() => _Ejercicio6ScreenState();
}

class _Ejercicio6ScreenState extends State<Ejercicio6Screen> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _logica = Ejercicio6();
  int _clave = 1;

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _agregar() {
    if (!_formKey.currentState!.validate()) return;

    final valor = leerDecimal(_valorController.text)!;
    setState(() {
      _logica.agregar(_clave, valor);
    });
    _valorController.clear();
    FocusScope.of(context).unfocus();
    mostrarMensaje(context, 'Vehículo agregado');
  }

  void _limpiar() {
    setState(() {
      _logica.limpiar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehiculos = _logica.vehiculos;

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 6: Impuesto de vehículos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese la clave y el valor de cada vehículo. '
              'Clave 1 paga 10%, clave 2 paga 7% y clave 3 paga 5%.',
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: _clave,
                    decoration: const InputDecoration(
                      labelText: 'Clave del vehículo',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Clave 1 (10%)')),
                      DropdownMenuItem(value: 2, child: Text('Clave 2 (7%)')),
                      DropdownMenuItem(value: 3, child: Text('Clave 3 (5%)')),
                    ],
                    onChanged: (valor) {
                      if (valor != null) {
                        setState(() => _clave = valor);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _valorController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Valor del vehículo (\$)',
                      border: OutlineInputBorder(),
                    ),
                    validator: validarPositivo,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _agregar,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar vehículo'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (vehiculos.isEmpty)
              const Text('Aún no se han agregado vehículos.')
            else ...[
              TarjetaResultado(
                titulo: 'Vehículos registrados (${vehiculos.length})',
                lineas: [
                  for (int i = 0; i < vehiculos.length; i++)
                    '${i + 1}. Clave ${vehiculos[i].clave} | '
                        'Valor: ${formatoDinero(vehiculos[i].valor)} | '
                        'Impuesto: ${formatoDinero(vehiculos[i].impuesto)}',
                ],
              ),
              TarjetaResultado(
                titulo: 'Total de impuestos',
                lineas: [
                  for (int clave = 1; clave <= 3; clave++)
                    'Clave $clave: ${_logica.cantidadPorClave(clave)} vehículo(s), '
                        '${formatoDinero(_logica.totalPorClave(clave))}',
                  'Total de todos los vehículos: '
                      '${formatoDinero(_logica.totalGeneral)}',
                ],
              ),
              TextButton(
                onPressed: _limpiar,
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
