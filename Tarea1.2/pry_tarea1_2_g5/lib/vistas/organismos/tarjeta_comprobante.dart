import 'package:flutter/material.dart';

import '../../modelos/modelo_recarga.dart';
import '../../tema/colores_app.dart';
import '../../tema/imagenes_app.dart';
import '../../utilidades/formato.dart';
import '../atomos/boton_app.dart';
import '../atomos/imagen_app.dart';
import '../atomos/logo_operadora.dart';
import '../atomos/titulo_app.dart';
import '../moleculas/detalle_fila.dart';
import '../moleculas/fila_comprobante.dart';

/// ORGANISMO: tarjeta blanca con el detalle final de la recarga.
class ComprobanteCard extends StatelessWidget {
  final RecargaModel recarga;
  final VoidCallback onBackHome;

  const ComprobanteCard({super.key, required this.recarga, required this.onBackHome});

  @override
  Widget build(BuildContext context) {
    const separador = Divider(height: 1, color: Color(0xFFEEE8EA));

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 22, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.blanco,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: AppTitle('Comprobante de recarga', tamano: 21),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 2, 18, 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEE8EA)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                ComprobanteItem(
                  icono: const AppImage(AppImages.icTelefono),
                  etiqueta: 'Número telefónico',
                  valor: Formato.telefono(recarga.numero),
                ),
                separador,
                ComprobanteItem(
                  icono: OperadoraLogo(nombre: recarga.operadora.nombre, alto: 42, circular: true),
                  etiqueta: 'Operadora',
                  valor: recarga.operadora.nombre,
                ),
                separador,
                ComprobanteItem(
                  icono: const AppImage(AppImages.icValor),
                  etiqueta: 'Valor de la recarga',
                  valor: Formato.dinero(recarga.valor),
                ),
                separador,
                ComprobanteItem(
                  icono: const AppImage(AppImages.icComision),
                  etiqueta: 'Comisión de servicio (${Formato.porcentaje(recarga.porcentajeComision)})',
                  valor: Formato.dinero(recarga.comision),
                ),
                separador,
                ComprobanteItem(
                  icono: const AppImage(AppImages.icTotal),
                  etiqueta: 'Total a pagar',
                  valor: Formato.dinero(recarga.total),
                ),
                const SizedBox(height: 6),
                separador,
                const SizedBox(height: 10),
                DetalleFila(icono: Icons.credit_card, etiqueta: 'Forma de pago', valor: recarga.formaPago),
                DetalleFila(
                  icono: Icons.calendar_today_outlined,
                  etiqueta: 'Fecha y hora',
                  valor: Formato.fecha(recarga.fecha),
                ),
                DetalleFila(
                  icono: Icons.tag,
                  etiqueta: 'Número de operación',
                  valor: '# ${recarga.numeroComprobante}',
                ),
                const SizedBox(height: 12),

                // Ganancia del establecimiento
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  decoration: BoxDecoration(
                    color: AppColors.verdeClaro,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const AppImage(AppImages.icGanancia, alto: 26),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ganancia del establecimiento',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              Formato.dinero(recarga.ganancia),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(${Formato.porcentaje(recarga.operadora.porcentajeGanancia)} de la recarga)',
                              style: const TextStyle(fontSize: 11, color: AppColors.textoSuave),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            texto: 'Volver al inicio',
            icono: Icons.home_outlined,
            color: AppColors.verdeBoton,
            onPressed: onBackHome,
          ),
        ],
      ),
    );
  }
}
