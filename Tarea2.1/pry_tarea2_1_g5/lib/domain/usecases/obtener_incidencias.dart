import '../entities/incidencia.dart';
import '../repositories/incidencia_repository.dart';
class ObtenerIncidencias {
  final IncidenciaRepository repository;
  ObtenerIncidencias(this.repository);
  Future<List<Incidencia>> ejecutar() => repository.obtenerIncidencias();
}
