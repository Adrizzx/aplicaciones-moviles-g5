import 'package:flutter/material.dart';

import '../logic/ejercicio10_logica.dart';
import '../utils/validaciones.dart';
import '../widgets/comunes.dart';

class Ejercicio10Screen extends StatefulWidget {
  const Ejercicio10Screen({super.key});

  @override
  State<Ejercicio10Screen> createState() => _Ejercicio10ScreenState();
}

class _Ejercicio10ScreenState extends State<Ejercicio10Screen> {
  final _formLimites = GlobalKey<FormState>();
  final _formNumero = GlobalKey<FormState>();
  final _inferiorController = TextEditingController();
  final _superiorController = TextEditingController();
  final _numeroController = TextEditingController();

  Intervalo? _intervalo;

  @override
  void dispose() {
    _inferiorController.dispose();
    _superiorController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  // El límite superior se valida comparándolo con el inferior.
  // Si el inferior es mayor (o igual) se vuelve a pedir.
  String? _validarSuperior(String? texto) {
    final error = validarNumero(texto);
    if (error != null) return error;
    final inferior = leerDecimal(_inferiorController.text);
    final superior = leerDecimal(texto)!;
    if (inferior != null && inferior >= superior) {
      return 'Debe ser mayor que el límite inferior, vuelva a ingresarlo';
    }
    return null;
  }

  void _fijarIntervalo() {
    if (!_formLimites.currentState!.validate()) return;
    setState(() {
      _intervalo = Intervalo(
        leerDecimal(_inferiorController.text)!,
        leerDecimal(_superiorController.text)!,
      );
    });
    FocusScope.of(context).unfocus();
  }

  void _agregarNumero() {
    if (!_formNumero.currentState!.validate()) return;
    final numero = leerDecimal(_numeroController.text)!;
    setState(() {
      _intervalo!.agregar(numero);
    });
    _numeroController.clear();
    if (numero == 0) {
      FocusScope.of(context).unfocus();
    }
  }

  void _reiniciar() {
    _inferiorController.clear();
    _superiorController.clear();
    _numeroController.clear();
    setState(() => _intervalo = null);
  }

  @override
  Widget build(BuildContext context) {
    final intervalo = _intervalo;

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 10: Intervalo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Paso 1: ingrese los límites del intervalo. '
              'Paso 2: ingrese números; escriba 0 para terminar.',
            ),
            const SizedBox(height: 16),
            Form(
              key: _formLimites,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _inferiorController,
                      enabled: intervalo == null,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Límite inferior',
                        border: OutlineInputBorder(),
                      ),
                      validator: validarNumero,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _superiorController,
                      enabled: intervalo == null,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Límite superior',
                        border: OutlineInputBorder(),
                        errorMaxLines: 3,
                      ),
                      validator: _validarSuperior,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (intervalo == null)
              ElevatedButton(
                onPressed: _fijarIntervalo,
                child: const Text('Fijar intervalo'),
              )
            else ...[
              Text(
                'Intervalo abierto: (${formatoNumero(intervalo.inferior)}, '
                '${formatoNumero(intervalo.superior)})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (!intervalo.terminado) ...[
                Form(
                  key: _formNumero,
                  child: TextFormField(
                    controller: _numeroController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Número (0 para terminar)',
                      border: OutlineInputBorder(),
                    ),
                    validator: validarNumero,
                    onFieldSubmitted: (_) => _agregarNumero(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _agregarNumero,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar número'),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                intervalo.numeros.isEmpty
                    ? 'Números ingresados: ninguno'
                    : 'Números ingresados: '
                        '${intervalo.numeros.map(formatoNumero).join(', ')}',
              ),
              const SizedBox(height: 12),
              if (intervalo.terminado) ...[
                TarjetaResultado(
                  titulo: 'Resultados',
                  lineas: [
                    'Suma de los números dentro del intervalo: '
                        '${formatoNumero(intervalo.sumaDentro)}',
                    'Cantidad de números fuera del intervalo: '
                        '${intervalo.cantidadFuera}',
                    intervalo.hayIgualALimite
                        ? 'Sí se ingresó al menos un número igual a los límites.'
                        : 'No se ingresó ningún número igual a los límites.',
                  ],
                ),
                OutlinedButton(
                  onPressed: _reiniciar,
                  child: const Text('Nuevo intervalo'),
                ),
              ],
            ],
            const SizedBox(height: 8),
            const BotonVolver(),
          ],
        ),
      ),
    );
  }
}
