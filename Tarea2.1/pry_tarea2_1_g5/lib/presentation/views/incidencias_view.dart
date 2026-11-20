import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/incidencia_viewmodel.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/encabezado_app.dart';

class IncidenciasView extends StatefulWidget {
  const IncidenciasView({super.key});
  @override
  State<IncidenciasView> createState() => _IncidenciasViewState();
}

class _IncidenciasViewState extends State<IncidenciasView> {
  String? filtroArea;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) context.read<IncidenciaViewModel>().cargar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionViewModel>();
    final gestion =
        ModalRoute.of(context)?.settings.arguments == true &&
        sesion.esAdministrador;
    final vm = context.watch<IncidenciaViewModel>();
    final registros = vm.incidencias
        .where(
          (i) => gestion
              ? (filtroArea == null || i.areaId == filtroArea)
              : (sesion.esAdministrador ||
                    i.usuarioId == sesion.usuarioActual?.id),
        )
        .toList();
    return Scaffold(
      appBar: EncabezadoApp(
        titulo: gestion
            ? 'Gestionar incidencias'
            : sesion.esAdministrador
            ? 'Todas las incidencias'
            : 'Mis incidencias',
        acciones: [
          IconButton(
            onPressed: () => vm.cargar(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: vm.cargando
          ? const Center(child: CircularProgressIndicator())
          : vm.error.isNotEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(vm.error),
              ),
            )
          : Column(
              children: [
                if (gestion)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField<String>(
                      initialValue: filtroArea,
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por área',
                        prefixIcon: Icon(Icons.business_outlined),
                      ),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Todas'),
                        ),
                        ...vm.areas.map(
                          (a) => DropdownMenuItem(
                            value: a.id,
                            child: Text(a.nombre),
                          ),
                        ),
                      ],
                      onChanged: (valor) => setState(() => filtroArea = valor),
                    ),
                  ),
                Expanded(
                  child: registros.isEmpty
                      ? const Center(child: Text('No hay incidencias'))
                      : ListView.builder(
                          itemCount: registros.length,
                          itemBuilder: (context, index) {
                            final i = registros[index];
                            final colorPrioridad = switch (i.prioridad) {
                              'Crítica' => ColoresApp.prioridadCritica,
                              'Alta' => ColoresApp.prioridadAlta,
                              'Media' => ColoresApp.prioridadMedia,
                              'Baja' => ColoresApp.prioridadBaja,
                              _ => ColoresApp.textoSecundario,
                            };
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              child: ListTile(
                                title: Text(i.titulo),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    bottom: 4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(child: Text(i.ubicacion)),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.schedule_outlined,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              i.fecha
                                                  .toLocal()
                                                  .toString()
                                                  .split('.')
                                                  .first,
                                              style: const TextStyle(
                                                color:
                                                    ColoresApp.textoSecundario,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${i.estado} · ${i.prioridadVisible}',
                                      ),
                                      if (i.areaId != null)
                                        Text(
                                          'Área: ${vm.buscarArea(i.areaId)?.nombre ?? i.areaId}',
                                        ),
                                      Text(
                                        'Reportó: ${vm.buscarUsuario(i.usuarioId)?.nombre ?? i.usuarioId}',
                                      ),
                                    ],
                                  ),
                                ),
                                isThreeLine: true,
                                leading: CircleAvatar(
                                  backgroundColor: ColoresApp.verdeSuave,
                                  child: Icon(
                                    i.prioridad == 'Crítica'
                                        ? Icons.priority_high
                                        : Icons.report_outlined,
                                    color: colorPrioridad,
                                  ),
                                ),
                                trailing: gestion && i.estado != 'Cerrada'
                                    ? IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          await Navigator.pushNamed(
                                            context,
                                            AppRoutes.gestionar,
                                            arguments: i,
                                          );
                                          if (context.mounted) {
                                            context
                                                .read<IncidenciaViewModel>()
                                                .cargar();
                                          }
                                        },
                                      )
                                    : const Icon(Icons.chevron_right),
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.detalle,
                                  arguments: i,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.formulario),
        label: const Text('Reportar'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
