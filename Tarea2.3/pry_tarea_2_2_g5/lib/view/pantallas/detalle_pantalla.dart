import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/model/mascota_model.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view/widgets/boton_pildora.dart';
import 'package:tarea22/view/widgets/zona_interes.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

class DetallePantalla extends StatelessWidget {
  const DetallePantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final mascota = ModalRoute.of(context)!.settings.arguments as MascotaModel;
    final vm = context.watch<MascotaViewmodel>();
    final interesa = vm.tieneInteres(mascota);
    final favorita = vm.esFavorita(mascota);

    Widget dato(String icono, String titulo, String valor, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Text(icono, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(fontSize: 12, color: Tema.texto),
                    ),
                    Text(
                      valor,
                      style: const TextStyle(
                        fontSize: 15,
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
      );
    }

    final foto = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(mascota.imagen, fit: BoxFit.cover),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          vm.seleccionada?.nombre ?? 'Detalle',
          style: Tema.titulo.copyWith(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Tema.crema,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Tema.verdeOscuro),
        actions: [
          IconButton(
            onPressed: () {
              context.read<MascotaViewmodel>().alternarFavorita(mascota);
            },
            icon: Icon(
              favorita ? Icons.favorite : Icons.favorite_border,
              color: favorita ? Colors.red : Tema.verdeOscuro,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: Tema.fondo),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  // Gesto 2: la foto se arrastra hasta la zona "Me interesa".
                  child: Draggable<MascotaModel>(
                    data: mascota,
                    maxSimultaneousDrags: interesa ? 0 : 1,
                    // Mantiene la foto pequeña centrada bajo el dedo.
                    dragAnchorStrategy: (draggable, context, posicion) =>
                        const Offset(70, 52),
                    feedback: SizedBox(width: 140, height: 105, child: foto),
                    childWhenDragging: Opacity(opacity: 0.3, child: foto),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        foto,
                        if (!interesa)
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '🐾 Arrástrame',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Tema.verdeOscuro,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: Tema.mentaMedia,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${mascota.nombre} ${mascota.icono}',
                          style: Tema.titulo.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            dato('🎂', 'Edad', mascota.edad, Tema.durazno),
                            const SizedBox(width: 10),
                            dato('🐾', 'Raza', mascota.raza, Tema.menta),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ZonaInteres(mascota: mascota),
                const SizedBox(height: 15),
                BotonPildora(
                  texto: 'Regresar',
                  alPresionar: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
