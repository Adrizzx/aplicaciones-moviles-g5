import 'package:flutter/material.dart';
import 'package:tarea22/view/tema.dart';

class Encabezado extends StatelessWidget {
  final int favoritas;

  const Encabezado({super.key, required this.favoritas});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 10,
      ),
      decoration: const BoxDecoration(
        gradient: Tema.encabezado,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Patitas',
            textAlign: TextAlign.center,
            style: Tema.logo.copyWith(fontSize: 38),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Hola, amigo peludo! 🐾',
                        style: Tema.titulo.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '¿A quién vas a adoptar hoy?',
                        style: TextStyle(color: Tema.texto),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Favoritas: $favoritas',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Tema.verdeOscuro,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset('assets/mascotas/asomado.png', height: 120),
            ],
          ),
        ],
      ),
    );
  }
}
