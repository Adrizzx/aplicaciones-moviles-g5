import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/model/mascota_model.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

class MascotaTarjeta extends StatelessWidget {
  final MascotaModel mascota;

  const MascotaTarjeta({super.key, required this.mascota});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MascotaViewmodel>();
    final favorita = vm.esFavorita(mascota);

    Widget etiqueta(String texto, Color fondo, Color letra) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: fondo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(texto, style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: letra,
          )),
      );
    }

    return GestureDetector(
      onTap: () {
        context.read<MascotaViewmodel>().seleccionarMascota(mascota);
        Navigator.pushNamed(context, '/detalle', arguments: mascota);
      },
      // Gesto 1: doble toque para agregar o quitar de favoritas.
      onDoubleTap: () {
        context.read<MascotaViewmodel>().alternarFavorita(mascota);
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: Tema.mentaMedia,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    mascota.imagen,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: Text(
                      mascota.icono,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            mascota.nombre,
            style: Tema.titulo.copyWith(fontSize: 20),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                etiqueta(
                  mascota.raza,
                  Tema.menta,
                  Tema.verdeOscuro,
                ),
                etiqueta(
                  mascota.edad,
                  Tema.durazno,
                  const Color(0xFF9A5B2C),
                ),
                if (vm.tieneInteres(mascota))
                  etiqueta(
                    '✓ Me interesa',
                    Colors.blue.shade50,
                    Colors.blue.shade800,
                  ),
              ],
            ),
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundColor: favorita
                ? Colors.red.shade50
                : Colors.grey.shade100,
            child: AnimatedScale(
              scale: favorita ? 1.2 : 1,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                favorita ? Icons.favorite : Icons.favorite_border,
                color: favorita ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
