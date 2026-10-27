import 'package:flutter/material.dart';

import '../../modelos/modelo_recarga.dart';
import '../../tema/colores_app.dart';
import '../../utilidades/formato.dart';
import '../moleculas/detalle_fila.dart';

/// ORGANISMO: resumen rosado con comisión y total (se actualiza en vivo).
class ResumenCard extends StatelessWidget {
  final RecargaModel? recarga; // null si aún faltan datos

  const ResumenCard({super.key, required this.recarga});

  @override
  Widget build(BuildContext context) {
    final r = recarga;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      decoration: BoxDecoration(
        color: AppColors.rosaResumen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          DetalleFila(
            etiqueta: 'Comisión de servicio',
            valor: r == null ? '--' : Formato.porcentaje(r.porcentajeComision),
            negrita: true,
          ),
          DetalleFila(etiqueta: 'Valor de la recarga', valor: Formato.dinero(r?.valor ?? 0.0)),
          DetalleFila(etiqueta: 'Comisión', valor: Formato.dinero(r?.comision ?? 0.0)),
          const Divider(color: Color(0xFFE6D3DB), height: 18),
          DetalleFila(
            etiqueta: 'Total a pagar',
            valor: Formato.dinero(r?.total ?? 0.0),
            destacado: true,
          ),
        ],
      ),
    );
  }
}
