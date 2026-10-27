import 'package:flutter/material.dart';

import '../../modelos/modelo_recarga.dart';
import '../../tema/colores_app.dart';
import '../../tema/imagenes_app.dart';
import '../../tema/tema_app.dart';
import '../atomos/imagen_app.dart';
import '../organismos/tarjeta_comprobante.dart';

/// PANTALLA 3: Comprobante de la recarga.
class ComprobanteScreen extends StatelessWidget {
  const ComprobanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibe la recarga enviada desde la pantalla anterior
    final recarga = ModalRoute.of(context)!.settings.arguments as RecargaModel;

    return Scaffold(
      backgroundColor: AppColors.fondoComprobante,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Encabezado verde con el check
                Container(
                  height: 380,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.verdeOscuro,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const AppImage(AppImages.exito, alto: 96),
                        const SizedBox(height: 12),
                        const Text(
                          '¡Recarga exitosa!',
                          style: TextStyle(
                            fontFamily: AppTheme.fuenteTitulos,
                            fontSize: 28,
                            color: Colors.white,
                            fontVariations: [FontVariation('wght', 500)],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tu recarga ha sido procesada correctamente.',
                          style: TextStyle(
                            fontFamily: AppTheme.fuenteTitulos,
                            color: Color(0xFFE3EAE8),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tarjeta del comprobante encima del encabezado
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 290, 14, 0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: ComprobanteCard(
                        recarga: recarga,
                        onBackHome: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Onda rosada con "¡Gracias por tu preferencia!"
            const AppImage(AppImages.ondaComprobante, fit: BoxFit.fitWidth),
          ],
        ),
      ),
    );
  }
}
