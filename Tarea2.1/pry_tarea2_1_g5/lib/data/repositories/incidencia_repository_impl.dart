import '../../domain/entities/incidencia.dart';
import '../../domain/repositories/incidencia_repository.dart';
import '../datasources/incidencia_api.dart';
import '../models/incidencia_model.dart';

class IncidenciaRepositoryImpl implements IncidenciaRepository {
  final IncidenciaApi api;
  IncidenciaRepositoryImpl(this.api);

  @override
  Future<List<Incidencia>> obtenerIncidencias() => api.obtenerIncidencias();
  @override
  Future<Incidencia> crearIncidencia(Incidencia incidencia) =>
      api.crearIncidencia(IncidenciaModel.desdeEntidad(incidencia));
  @override
  Future<Incidencia> actualizarIncidencia(Incidencia incidencia) =>
      api.actualizarIncidencia(IncidenciaModel.desdeEntidad(incidencia));
}
