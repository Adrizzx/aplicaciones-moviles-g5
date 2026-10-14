import 'package:flutter/material.dart';

import '../logic/ejercicio9_logica.dart';
import '../utils/validaciones.dart';
import '../widgets/comunes.dart';

class Ejercicio9Screen extends StatefulWidget {
  const Ejercicio9Screen({super.key});

  @override
  State<Ejercicio9Screen> createState() => _Ejercicio9ScreenState();
}

class _Ejercicio9ScreenState extends State<Ejercicio9Screen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();

  JuegoAdivinar _juego = JuegoAdivinar();
  final List<String> _historial = [];
  String _mensaje = 'Adivina el número entre 1 y 100. Tienes 10 intentos.';

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  String? _validarIntento(String? texto) {
    if (texto == null || texto.trim().isEmpty) {
      return 'Ingrese un número';
    }
    final numero = leerEntero(texto);
    if (numero == null) {
      return 'Ingrese un número entero';
    }
    if (numero < JuegoAdivinar.minimo || numero > JuegoAdivinar.maximo) {
      return 'El número debe estar entre 1 y 100';
    }
    return null;
  }

  void _probar() {
    if (!_formKey.currentState!.validate()) return;

    final numero = leerEntero(_numeroController.text)!;
    final resultado = _juego.intentar(numero);

    setState(() {
      switch (resultado.pista) {
        case Pista.acierto:
          _mensaje = '¡Correcto! El número era $numero. '
              'Lo adivinaste en ${_juego.intentosUsados} intento(s).';
          _historial.add('$numero: correcto');
          break;
        case Pista.mayor:
          _mensaje = 'El número a adivinar es MAYOR que $numero.';
          _historial.add('$numero: es mayor');
          break;
        case Pista.menor:
          _mensaje = 'El número a adivinar es MENOR que $numero.';
          _historial.add('$numero: es menor');
          break;
      }

      if (_juego.terminado && !_juego.gano) {
        _mensaje = 'Se acabaron los intentos. '
            'El número era ${_juego.numeroSecreto}.';
      }
    });
    _numeroController.clear();
  }

  void _reiniciar() {
    setState(() {
      _juego = JuegoAdivinar();
      _historial.clear();
      _mensaje = 'Nuevo juego. Adivina el número entre 1 y 100.';
    });
    _numeroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final terminado = _juego.terminado;

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 9: Adivina el número')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: terminado
                  ? (_juego.gano ? Colors.green.shade100 : Colors.red.shade100)
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _mensaje,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intentos restantes: ${_juego.intentosRestantes}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _numeroController,
                enabled: !terminado,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tu número (1 a 100)',
                  border: OutlineInputBorder(),
                ),
                validator: _validarIntento,
                onFieldSubmitted: (_) => _probar(),
              ),
            ),
            const SizedBox(height: 12),
            if (!terminado)
              ElevatedButton.icon(
                onPressed: _probar,
                icon: const Icon(Icons.send),
                label: const Text('Probar'),
              )
            else
              ElevatedButton.icon(
                onPressed: _reiniciar,
                icon: const Icon(Icons.refresh),
                label: const Text('Jugar otra vez'),
              ),
            const SizedBox(height: 16),
            if (_historial.isNotEmpty)
              TarjetaResultado(
                titulo: 'Intentos realizados',
                lineas: [
                  for (int i = 0; i < _historial.length; i++)
                    'Intento ${i + 1}: ${_historial[i]}',
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
