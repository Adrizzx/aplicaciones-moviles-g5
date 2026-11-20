import 'package:flutter/material.dart';
import '../../domain/entities/incidencia.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/entities/area_responsable.dart';
import '../../domain/usecases/obtener_incidencias.dart';
import '../../domain/usecases/crear_incidencia.dart';
import '../../domain/usecases/actualizar_incidencia.dart';
import '../../domain/usecases/obtener_usuarios.dart';
import '../../domain/usecases/obtener_area_responsables.dart';

class IncidenciaViewModel extends ChangeNotifier {
  final ObtenerIncidencias obtener;
  final CrearIncidencia crear;
  final ActualizarIncidencia actualizar;
  final ObtenerUsuarios obtenerUsuarios;
  final ObtenerAreaResponsables obtenerAreas;

  IncidenciaViewModel(this.obtener, this.crear, this.actualizar,
      this.obtenerUsuarios, this.obtenerAreas);

  List<Incidencia> incidencias = [];
  List<Usuario> usuarios = [];
  List<AreaResponsable> areas = [];
  bool cargando = false;
  String error = '';

  Future<void> cargar() async {
    cargando = true;
    error = '';
    notifyListeners();
    try {
      final resultados = await Future.wait<dynamic>([
        obtener.ejecutar(), obtenerUsuarios.ejecutar(), obtenerAreas.ejecutar()
      ]);
      incidencias = resultados[0] as List<Incidencia>;
      usuarios = resultados[1] as List<Usuario>;
      areas = resultados[2] as List<AreaResponsable>;
      const orden = {'Crítica': 0, 'Alta': 1, 'Media': 2, 'Baja': 3};
      incidencias.sort((a, b) {
        final p = (orden[a.prioridad] ?? 4).compareTo(orden[b.prioridad] ?? 4);
        return p != 0 ? p : b.fecha.compareTo(a.fecha);
      });
    } catch (e) {
      error = 'No se pudieron obtener los datos: $e';
    } finally {
      cargando = false;
      notifyListeners();
    }
  }

  Future<void> agregar(Incidencia incidencia) async {
    await crear.ejecutar(incidencia);
    await cargar();
  }

  Future<void> editar(Incidencia original, {required String? prioridad,
    required String estado, String? areaId, required String observacionSolucion}) async {
    await actualizar.ejecutar(original, prioridad: prioridad, estado: estado,
      areaId: areaId, observacionSolucion: observacionSolucion);
    await cargar();
  }

  Usuario? buscarUsuario(String id) {
    for (final usuario in usuarios) { if (usuario.id == id) return usuario; }
    return null;
  }

  AreaResponsable? buscarArea(String? id) {
    for (final area in areas) { if (area.id == id) return area; }
    return null;
  }
}
