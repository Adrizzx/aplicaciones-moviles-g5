import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/incidencia.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/incidencia_viewmodel.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/encabezado_app.dart';

class FormularioIncidenciaView extends StatefulWidget {
  const FormularioIncidenciaView({super.key});
  @override
  State<FormularioIncidenciaView> createState() =>
      _FormularioIncidenciaViewState();
}

class _FormularioIncidenciaViewState extends State<FormularioIncidenciaView> {
  final formulario = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final descripcion = TextEditingController();
  final ubicacion = TextEditingController();
  late final DateTime fechaReporte;
  bool guardando = false;

  @override
  void initState() {
    super.initState();
    fechaReporte = DateTime.now();
    Future.microtask(() {
      if (mounted) context.read<IncidenciaViewModel>().cargar();
    });
  }

  @override
  void dispose() {
    titulo.dispose();
    descripcion.dispose();
    ubicacion.dispose();
    super.dispose();
  }

  Future<void> guardar() async {
    if (!formulario.currentState!.validate()) return;
    setState(() => guardando = true);
    try {
      await context.read<IncidenciaViewModel>().agregar(
        Incidencia(
          id: null,
          usuarioId: context.read<SesionViewModel>().usuarioActual!.id,
          titulo: titulo.text,
          descripcion: descripcion.text,
          ubicacion: ubicacion.text,
          fecha: fechaReporte,
          estado: 'Reportada',
          observacionSolucion: '',
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Incidencia registrada')));
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
    final vm = context.watch<IncidenciaViewModel>();
    final usuario = context.watch<SesionViewModel>().usuarioActual!;
    final fechaVisible =
        '${fechaReporte.day.toString().padLeft(2, '0')}/'
        '${fechaReporte.month.toString().padLeft(2, '0')}/${fechaReporte.year}';
    Widget datoAutomatico(IconData icono, String etiqueta, String valor) =>
        CampoFormulario(
          icono: icono,
          etiqueta: etiqueta,
          campo: TextFormField(
            initialValue: valor,
            readOnly: true,
            decoration: const InputDecoration(
              fillColor: ColoresApp.verdeSuave,
              suffixIcon: Icon(Icons.lock_outline),
            ),
          ),
        );
    return Scaffold(
      appBar: const EncabezadoApp(titulo: 'Reportar incidencia'),
      body: vm.cargando
          ? const Center(child: CircularProgressIndicator())
          : vm.error.isNotEmpty
          ? Center(child: Text(vm.error))
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Form(
                  key: formulario,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: ColoresApp.verdeOscuro,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reporta:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    Text(
                                      usuario.nombre,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 115,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: ColoresApp.verdeSuave,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  usuario.tipo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: ColoresApp.verdeOscuro,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CampoFormulario(
                        etiqueta: 'Título',
                        icono: Icons.title,
                        obligatorio: true,
                        campo: TextFormField(
                          controller: titulo,
                          decoration: const InputDecoration(
                            hintText: 'Ej. Falla de internet en laboratorio',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Ingrese un título'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 18),
                      CampoFormulario(
                        etiqueta: 'Descripción',
                        icono: Icons.description_outlined,
                        obligatorio: true,
                        campo: TextFormField(
                          controller: descripcion,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Describe el problema encontrado...',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Ingrese una descripción'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 18),
                      CampoFormulario(
                        etiqueta: 'Ubicación',
                        icono: Icons.location_on_outlined,
                        obligatorio: true,
                        campo: TextFormField(
                          controller: ubicacion,
                          decoration: const InputDecoration(
                            hintText: 'Ej. Bloque B, aula 205',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Ingrese una ubicación'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 18),
                      LayoutBuilder(
                        builder: (context, limites) => limites.maxWidth >= 440
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: datoAutomatico(
                                      Icons.calendar_today_outlined,
                                      'Fecha de reporte',
                                      fechaVisible,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: datoAutomatico(
                                      Icons.check_circle_outline,
                                      'Estado',
                                      'Reportada',
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  datoAutomatico(
                                    Icons.calendar_today_outlined,
                                    'Fecha de reporte',
                                    fechaVisible,
                                  ),
                                  const SizedBox(height: 18),
                                  datoAutomatico(
                                    Icons.check_circle_outline,
                                    'Estado',
                                    'Reportada',
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: guardando ? null : guardar,
                        icon: const Icon(Icons.send_outlined),
                        label: Text(
                          guardando ? 'Guardando...' : 'Registrar incidencia',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
