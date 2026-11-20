import '../entities/incidencia.dart';
import '../repositories/incidencia_repository.dart';

class ActualizarIncidencia {
  final IncidenciaRepository repository;
  ActualizarIncidencia(this.repository);

  Future<Incidencia> ejecutar(Incidencia original, {
    required String? prioridad, required String estado, String? areaId,
    required String observacionSolucion}) async {
    if (original.estado == 'Cerrada') throw Exception('Una incidencia cerrada no puede modificarse');
    if (prioridad != null && !Incidencia.prioridades.contains(prioridad)) throw Exception('Prioridad inválida');
    if (!Incidencia.estados.contains(estado)) throw Exception('Estado inválido');
    const siguiente = {
      'Reportada': 'Asignada', 'Asignada': 'En proceso',
      'En proceso': 'Resuelta', 'Resuelta': 'Cerrada',
    };
    final areaAsignada = areaId != null && areaId.trim().isNotEmpty;
    final nuevoEstado = original.estado == 'Reportada' && estado == 'Reportada' && areaAsignada
        ? 'Asignada' : estado;
    if (nuevoEstado != original.estado && siguiente[original.estado] != nuevoEstado) {
      throw Exception('Cambio de estado no permitido');
    }
    if (nuevoEstado != 'Reportada' && !areaAsignada) {
      throw Exception('Debe asignar un área responsable');
    }
    if (nuevoEstado == 'En proceso' && prioridad == null) {
      throw Exception('Debe clasificar la prioridad');
    }
    if (nuevoEstado == 'Resuelta' && observacionSolucion.trim().isEmpty) {
      throw Exception('Registre una observación de solución');
    }
    final actualizada = original.copiar(prioridad: prioridad, estado: nuevoEstado,
      areaId: areaId,
      observacionSolucion: nuevoEstado == 'Resuelta'
          ? observacionSolucion.trim() : original.observacionSolucion);
    return repository.actualizarIncidencia(actualizada);
  }
}
