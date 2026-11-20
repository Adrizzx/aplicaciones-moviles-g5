import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/incidencia.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/incidencia_viewmodel.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/encabezado_app.dart';

class GestionarIncidenciaView extends StatefulWidget {
  const GestionarIncidenciaView({super.key});
  @override
  State<GestionarIncidenciaView> createState() =>
      _GestionarIncidenciaViewState();
}

class _GestionarIncidenciaViewState extends State<GestionarIncidenciaView> {
  Incidencia? incidencia;
  String? areaId;
  String? prioridad;
  String estado = 'Reportada';
  final observacion = TextEditingController();
  bool guardando = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (incidencia == null) {
      incidencia = ModalRoute.of(context)!.settings.arguments as Incidencia;
      areaId = incidencia!.areaId;
      prioridad = incidencia!.prioridad;
      estado = incidencia!.estado;
      observacion.text = incidencia!.observacionSolucion;
    }
  }

  @override
  void dispose() {
    observacion.dispose();
    super.dispose();
  }

  Future<void> guardar() async {
    setState(() => guardando = true);
    try {
      await context.read<IncidenciaViewModel>().editar(
        incidencia!,
        prioridad: prioridad,
        estado: estado,
        areaId: areaId,
        observacionSolucion: observacion.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incidencia actualizada')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!context.watch<SesionViewModel>().esAdministrador) {
      return const Scaffold(
        body: Center(child: Text('Acceso exclusivo para administradores')),
      );
    }
    final i = incidencia!;
    final vm = context.watch<IncidenciaViewModel>();
    final usuario = vm.buscarUsuario(i.usuarioId);
    final fecha = i.fecha.toLocal();
    final fechaVisible =
        '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
    const siguientes = {
      'Reportada': 'Asignada',
      'Asignada': 'En proceso',
      'En proceso': 'Resuelta',
      'Resuelta': 'Cerrada',
    };
    final asignando = i.estado == 'Reportada';
    final opciones = [
      if (asignando) estado else i.estado,
      if (!asignando && siguientes[i.estado] != null) siguientes[i.estado]!,
    ];
    final cerrado = i.estado == 'Cerrada';
    final clasificacionBloqueada = i.estado == 'Resuelta' || cerrado;
    final datosReportante = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person_outline,
              size: 18,
              color: ColoresApp.verdeOscuro,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Reportado por',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          usuario?.nombre ?? i.usuarioId,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (usuario?.tipo.isNotEmpty == true) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: ColoresApp.verdeSuave,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              usuario!.tipo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: ColoresApp.verdeOscuro),
            ),
          ),
        ],
      ],
    );
    final datosFecha = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: ColoresApp.verdeOscuro,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Fecha de reporte',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(fechaVisible, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
    return Scaffold(
      appBar: const EncabezadoApp(titulo: 'Gestionar incidencia'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          i.titulo,
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
                          color: ColoresApp.verdeSuave,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          i.estado,
                          style: const TextStyle(color: ColoresApp.verdeOscuro),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: datosReportante),
                      const SizedBox(width: 12),
                      Expanded(child: datosFecha),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColoresApp.verdeSuave,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                  color: ColoresApp.verdeOscuro,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gestionar incidencia',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: ColoresApp.verdeOscuro,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Asigna el área y actualiza la atención',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CampoFormulario(
            etiqueta: 'Área responsable',
            icono: Icons.business_outlined,
            campo: DropdownButtonFormField<String>(
              initialValue: areaId,
              isExpanded: true,
              decoration: const InputDecoration(),
              items: vm.areas
                  .map(
                    (a) => DropdownMenuItem(
                      value: a.id,
                      child: Text(a.nombre, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: clasificacionBloqueada
                  ? null
                  : (valor) => setState(() {
                      areaId = valor;
                      if (asignando) {
                        estado = valor == null ? 'Reportada' : 'Asignada';
                      }
                    }),
            ),
          ),
          const SizedBox(height: 14),
          CampoFormulario(
            etiqueta: 'Prioridad',
            icono: Icons.flag_outlined,
            campo: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: Incidencia.prioridades.map((opcion) {
                  final color = switch (opcion) {
                    'Baja' => ColoresApp.prioridadBaja,
                    'Media' => ColoresApp.prioridadMedia,
                    'Alta' => ColoresApp.prioridadAlta,
                    _ => ColoresApp.prioridadCritica,
                  };
                  final seleccionada = prioridad == opcion;
                  return ChoiceChip(
                    label: Text(opcion),
                    selected: seleccionada,
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedColor: Color.lerp(ColoresApp.blanco, color, 0.22),
                    backgroundColor: Color.lerp(ColoresApp.blanco, color, 0.08),
                    side: BorderSide(
                      color: seleccionada
                          ? color
                          : Color.lerp(ColoresApp.blanco, color, 0.45)!,
                    ),
                    labelStyle: TextStyle(
                      color: color,
                      fontWeight: seleccionada
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    onSelected: clasificacionBloqueada
                        ? null
                        : (seleccionar) {
                            if (seleccionar) setState(() => prioridad = opcion);
                          },
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          CampoFormulario(
            etiqueta: 'Nuevo estado',
            icono: Icons.info_outline,
            campo: DropdownButtonFormField<String>(
              key: ValueKey(estado),
              initialValue: estado,
              isExpanded: true,
              decoration: InputDecoration(
                fillColor: asignando || cerrado
                    ? ColoresApp.verdeSuave
                    : ColoresApp.blanco,
              ),
              items: opciones
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: cerrado || asignando
                  ? null
                  : (valor) => setState(() => estado = valor!),
            ),
          ),
          const SizedBox(height: 14),
          if (estado == 'Resuelta' && i.estado == 'En proceso')
            CampoFormulario(
              etiqueta: 'Observación de solución',
              icono: Icons.notes,
              campo: TextFormField(controller: observacion, maxLines: 3),
            ),
          const SizedBox(height: 22),
          if (cerrado)
            const Text('Esta incidencia está cerrada y no puede modificarse.'),
          if (!cerrado)
            ElevatedButton.icon(
              onPressed: guardando ? null : guardar,
              icon: const Icon(Icons.save_outlined),
              label: Text(guardando ? 'Guardando...' : 'Guardar cambios'),
            ),
        ],
      ),
    );
  }
}
