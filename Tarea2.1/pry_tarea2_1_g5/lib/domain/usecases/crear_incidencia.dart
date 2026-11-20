import '../entities/incidencia.dart';
import '../repositories/incidencia_repository.dart';
class CrearIncidencia {
  final IncidenciaRepository repository;
  CrearIncidencia(this.repository);
  Future<Incidencia> ejecutar(Incidencia incidencia) {
    if (incidencia.usuarioId.trim().isEmpty) throw Exception('Seleccione un usuario');
    if (incidencia.titulo.trim().isEmpty || incidencia.descripcion.trim().isEmpty || incidencia.ubicacion.trim().isEmpty) {
      throw Exception('Complete todos los campos de la incidencia');
    }
    final nueva = Incidencia(id: null, usuarioId: incidencia.usuarioId,
      titulo: incidencia.titulo.trim(), descripcion: incidencia.descripcion.trim(),
      ubicacion: incidencia.ubicacion.trim(), fecha: incidencia.fecha,
      prioridad: null, estado: 'Reportada',
      areaId: null, observacionSolucion: '');
    return repository.crearIncidencia(nueva);
  }
}
