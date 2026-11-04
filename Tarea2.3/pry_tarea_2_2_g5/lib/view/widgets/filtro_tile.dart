import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

class FiltroTile extends StatelessWidget {
  final String etiqueta;
  final String icono;
  final Color color;

  const FiltroTile({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MascotaViewmodel>();
    final elegido = vm.filtro == etiqueta;

    return GestureDetector(
      onTap: () {
        context.read<MascotaViewmodel>().seleccionarFiltro(etiqueta);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: elegido ? Tema.verde : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(icono, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              etiqueta,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Tema.verdeOscuro,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
