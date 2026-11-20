import 'package:flutter/material.dart';

import '../../theme/colores_app.dart';

class FondoEncabezado extends StatelessWidget {
  const FondoEncabezado({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: ColoresApp.verdeOscuro,
        child: ClipRect(
          child: Stack(
            children: [
              Positioned(
                right: -58,
                top: -112,
                child: Container(
                  width: 205,
                  height: 205,
                  decoration: const BoxDecoration(
                    color: ColoresApp.verdeDecorativo,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: -53,
                bottom: -85,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: ColoresApp.mentaDecorativa,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(height: 3, color: ColoresApp.mentaLinea),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
