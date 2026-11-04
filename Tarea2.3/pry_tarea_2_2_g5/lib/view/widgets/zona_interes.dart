import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/model/mascota_model.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

class ZonaInteres extends StatelessWidget {
  final MascotaModel mascota;

  const ZonaInteres({super.key, required this.mascota});

  @override
  Widget build(BuildContext context) {
    final interesa = context.watch<MascotaViewmodel>().tieneInteres(mascota);

    return DragTarget<MascotaModel>(
      onAcceptWithDetails: (detalles) {
        context.read<MascotaViewmodel>().marcarInteres(detalles.data);
      },
      builder: (context, candidatos, rechazados) {
        final encima = candidatos.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: interesa || encima ? Tema.mentaMedia : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Tema.verde,
              width: encima ? 3 : 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    interesa ? '💚' : '🏡',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      interesa
                          ? '¡${mascota.nombre} te interesa!'
                          : 'Me interesa: arrastra la foto aquí',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Tema.verdeOscuro,
                      ),
                    ),
                  ),
                ],
              ),
              if (interesa)
                TextButton(
                  onPressed: () {
                    context.read<MascotaViewmodel>().quitarInteres(mascota);
                  },
                  child: const Text('Quitar interés'),
                ),
            ],
          ),
        );
      },
    );
  }
}
