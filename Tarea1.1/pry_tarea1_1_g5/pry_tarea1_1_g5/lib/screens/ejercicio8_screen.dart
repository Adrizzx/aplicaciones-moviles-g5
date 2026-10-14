import 'package:flutter/material.dart';

import '../logic/ejercicio8_logica.dart';
import '../utils/validaciones.dart';
import '../widgets/comunes.dart';

class Ejercicio8Screen extends StatefulWidget {
  const Ejercicio8Screen({super.key});

  @override
  State<Ejercicio8Screen> createState() => _Ejercicio8ScreenState();
}

class _Ejercicio8ScreenState extends State<Ejercicio8Screen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(12, (_) => TextEditingController());

  List<double>? _depositos;
  List<double>? _acumulado;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _calcular() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      mostrarMensaje(context, 'Revise los meses marcados en rojo');
      return;
    }

    final depositos = [
      for (final c in _controllers) leerDecimal(c.text)!,
    ];
    setState(() {
      _depositos = depositos;
      _acumulado = Ejercicio8.calcularAcumulado(depositos);
    });
  }

  void _limpiar() {
    for (final c in _controllers) {
      c.clear();
    }
    setState(() {
      _depositos = null;
      _acumulado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 8: Ahorro anual')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese lo que depositó al final de cada mes '
              '(puede ser 0 si ese mes no ahorró).',
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  for (int i = 0; i < 12; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _controllers[i],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Depósito de ${Ejercicio8.meses[i]} (\$)',
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        validator: validarNoNegativo,
                      ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calcular,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _limpiar,
                    child: const Text('Limpiar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_acumulado != null)
              TarjetaResultado(
                titulo: 'Ahorro acumulado por mes',
                lineas: [
                  for (int i = 0; i < 12; i++)
                    '${Ejercicio8.meses[i]}: depositó '
                        '${formatoDinero(_depositos![i])}, lleva ahorrado '
                        '${formatoDinero(_acumulado![i])}',
                  '',
                  'Total ahorrado en el año: '
                      '${formatoDinero(_acumulado!.last)}',
                ],
              ),
            const SizedBox(height: 8),
            const BotonVolver(),
          ],
        ),
      ),
    );
  }
}
