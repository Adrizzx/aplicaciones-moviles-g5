import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/incidencia.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/incidencia_viewmodel.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/encabezado_app.dart';

class DetalleIncidenciaView extends StatelessWidget {
  const DetalleIncidenciaView({super.key});

  @override
  Widget build(BuildContext context) {
    final inicial = ModalRoute.of(context)!.settings.arguments as Incidencia;
    final vm = context.watch<IncidenciaViewModel>();
    final incidencia =
        vm.incidencias.where((dato) => dato.id == inicial.id).firstOrNull ??
        inicial;
    final sesion = context.watch<SesionViewModel>();
    if (!sesion.esAdministrador &&
        incidencia.usuarioId != sesion.usuarioActual?.id) {
      return const Scaffold(
        body: Center(
          child: Text('No tiene permiso para consultar esta incidencia'),
        ),
      );
    }

    final usuario = vm.buscarUsuario(incidencia.usuarioId);
    final area = vm.buscarArea(incidencia.areaId);
    final fecha = incidencia.fecha.toLocal();
    final fechaVisible =
        '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
    final colorPrioridad = switch (incidencia.prioridad) {
      'Baja' => ColoresApp.prioridadBaja,
      'Media' => ColoresApp.prioridadMedia,
      'Alta' => ColoresApp.prioridadAlta,
      'Crítica' => ColoresApp.prioridadCritica,
      _ => ColoresApp.textoSecundario,
    };

    Widget tarjetaDato(
      IconData icono,
      String etiqueta,
      String valor, {
      Color? color,
    }) => Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icono, size: 20, color: ColoresApp.verdeOscuro),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    etiqueta,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: color == null
                    ? null
                    : Color.lerp(ColoresApp.blanco, color, 0.13),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                valor,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: color ?? ColoresApp.textoPrincipal),
              ),
            ),
          ],
        ),
      ),
    );

    Widget filaInformativa(
      IconData icono,
      String etiqueta,
      String valor, {
      String? tipo,
    }) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 22, color: ColoresApp.verdeOscuro),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(etiqueta, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 3),
                Text(valor, style: Theme.of(context).textTheme.bodyLarge),
                if (tipo != null && tipo.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColoresApp.verdeSuave,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      tipo,
                      style: const TextStyle(color: ColoresApp.verdeOscuro),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: const EncabezadoApp(titulo: 'Detalle de incidencia'),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: ColoresApp.verdeSuave,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.report_problem_outlined,
                            color: ColoresApp.verdeOscuro,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              incidencia.titulo,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: ColoresApp.verdeOscuro,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: ColoresApp.blanco,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              incidencia.estado,
                              style: const TextStyle(
                                color: ColoresApp.verdeOscuro,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.description_outlined,
                                color: ColoresApp.verdeOscuro,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Descripción',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(incidencia.descripcion),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, limites) => limites.maxWidth >= 320
                        ? IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: tarjetaDato(
                                    Icons.calendar_today_outlined,
                                    'Fecha',
                                    fechaVisible,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: tarjetaDato(
                                    Icons.flag_outlined,
                                    'Prioridad',
                                    incidencia.prioridadVisible,
                                    color: colorPrioridad,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              tarjetaDato(
                                Icons.calendar_today_outlined,
                                'Fecha',
                                fechaVisible,
                              ),
                              tarjetaDato(
                                Icons.flag_outlined,
                                'Prioridad',
                                incidencia.prioridadVisible,
                                color: colorPrioridad,
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Column(
                        children: [
                          filaInformativa(
                            Icons.person_outline,
                            'Reportado por',
                            usuario?.nombre ?? incidencia.usuarioId,
                            tipo: usuario?.tipo,
                          ),
                          const Divider(height: 1),
                          filaInformativa(
                            Icons.location_on_outlined,
                            'Ubicación',
                            incidencia.ubicacion,
                          ),
                          const Divider(height: 1),
                          filaInformativa(
                            Icons.business_outlined,
                            'Área responsable',
                            area?.nombre ?? 'Sin asignar',
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (incidencia.observacionSolucion.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: ColoresApp.verdeOscuro,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Observación de solución',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(incidencia.observacionSolucion),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
