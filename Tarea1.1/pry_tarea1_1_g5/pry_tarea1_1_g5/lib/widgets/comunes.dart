import 'package:flutter/material.dart';

/// Botón que regresa al menú principal.
class BotonVolver extends StatelessWidget {
  const BotonVolver({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.home),
      label: const Text('Volver al menú'),
    );
  }
}

/// Tarjeta sencilla para mostrar resultados.
class TarjetaResultado extends StatelessWidget {
  final String titulo;
  final List<String> lineas;

  const TarjetaResultado({
    super.key,
    required this.titulo,
    required this.lineas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final linea in lineas)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(linea),
              ),
          ],
        ),
      ),
    );
  }
}

/// Muestra un mensaje corto en la parte inferior de la pantalla.
void mostrarMensaje(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(mensaje)));
}
