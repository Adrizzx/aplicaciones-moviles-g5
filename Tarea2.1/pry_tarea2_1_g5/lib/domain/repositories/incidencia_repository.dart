import '../entities/incidencia.dart';
abstract class IncidenciaRepository {
  Future<List<Incidencia>> obtenerIncidencias();
  Future<Incidencia> crearIncidencia(Incidencia incidencia);
  Future<Incidencia> actualizarIncidencia(Incidencia incidencia);
}
