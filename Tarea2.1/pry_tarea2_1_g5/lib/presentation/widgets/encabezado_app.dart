import 'package:flutter/material.dart';

import '../../theme/colores_app.dart';
import 'fondo_encabezado.dart';

class EncabezadoApp extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final List<Widget>? acciones;

  const EncabezadoApp({super.key, required this.titulo, this.acciones});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 3);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColoresApp.verdeOscuro,
      foregroundColor: ColoresApp.blanco,
      elevation: 0,
      centerTitle: false,
      title: Text(
        titulo,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: ColoresApp.blanco,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: acciones,
      flexibleSpace: const FondoEncabezado(),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: const SizedBox(height: 3),
      ),
    );
  }
}
