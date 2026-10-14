import 'package:flutter/material.dart';

import '../rutas.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const List<_Opcion> _opciones = [
    _Opcion('Ejercicio 6', 'Impuesto de vehículos', Icons.directions_car,
        Rutas.ejercicio6),
    _Opcion('Ejercicio 7', 'Banco "Bandido de peluche"', Icons.account_balance,
        Rutas.ejercicio7),
    _Opcion('Ejercicio 8', 'Ahorro mensual en un año', Icons.savings,
        Rutas.ejercicio8),
    _Opcion('Ejercicio 9', 'Adivina el número', Icons.casino, Rutas.ejercicio9),
    _Opcion('Ejercicio 10', 'Números en un intervalo', Icons.straighten,
        Rutas.ejercicio10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú principal'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tarea 1.1: Creación y ejecución de una Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('Grupo 5 - NRC 36873'),
          const SizedBox(height: 16),
          for (final opcion in _opciones)
            Card(
              child: ListTile(
                leading: Icon(opcion.icono),
                title: Text(opcion.titulo),
                subtitle: Text(opcion.descripcion),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                // Navegación por nombre de ruta
                onTap: () => Navigator.pushNamed(context, opcion.ruta),
              ),
            ),
        ],
      ),
    );
  }
}

class _Opcion {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final String ruta;

  const _Opcion(this.titulo, this.descripcion, this.icono, this.ruta);
}
