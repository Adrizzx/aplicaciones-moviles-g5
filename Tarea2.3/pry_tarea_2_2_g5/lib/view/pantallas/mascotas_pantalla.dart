import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view/widgets/encabezado.dart';
import 'package:tarea22/view/widgets/filtro_tile.dart';
import 'package:tarea22/view/widgets/mascota_tarjeta.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

class MascotasPantalla extends StatelessWidget {
  const MascotasPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MascotaViewmodel>();
    final visibles = vm.mascotasVisibles;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Tema.fondo),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Encabezado(favoritas: vm.favoritas.length),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: FiltroTile(
                          etiqueta: 'Todas',
                          icono: '🐾',
                          color: Tema.menta,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FiltroTile(
                          etiqueta: 'Perros',
                          icono: '🐶',
                          color: Tema.durazno,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FiltroTile(
                          etiqueta: 'Gatos',
                          icono: '🐱',
                          color: Color(0xFFDCEBFA),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FiltroTile(
                          etiqueta: 'Favoritas',
                          icono: '❤️',
                          color: Color(0xFFFBE3E8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    decoration: BoxDecoration(
                      color: Tema.mentaMedia,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              'Adopta a tu nuevo mejor amigo',
                              style: Tema.titulo.copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                        Image.asset('assets/mascotas/pareja.png', height: 100),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Mascotas disponibles',
                    style: Tema.titulo.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Un toque: ver detalle  •  Doble toque: favorita',
                    style: TextStyle(fontSize: 13, color: Tema.texto),
                  ),
                  const SizedBox(height: 10),
                  if (visibles.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Todavía no tienes favoritas 💚',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Tema.texto),
                      ),
                    ),
                  for (final mascota in visibles)
                    MascotaTarjeta(mascota: mascota),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
