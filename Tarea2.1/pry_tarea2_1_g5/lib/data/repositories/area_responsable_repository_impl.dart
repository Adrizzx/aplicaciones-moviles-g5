import '../../domain/entities/area_responsable.dart';
import '../../domain/repositories/area_responsable_repository.dart';
import '../datasources/area_responsable_api.dart';

class AreaResponsableRepositoryImpl implements AreaResponsableRepository {
  final AreaResponsableApi api;
  AreaResponsableRepositoryImpl(this.api);
  @override
  Future<List<AreaResponsable>> obtenerAreaResponsables() => api.obtenerAreaResponsables();
}
