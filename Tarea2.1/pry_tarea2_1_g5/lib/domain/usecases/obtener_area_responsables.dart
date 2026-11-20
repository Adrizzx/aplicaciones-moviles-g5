import '../entities/area_responsable.dart';
import '../repositories/area_responsable_repository.dart';
class ObtenerAreaResponsables {
  final AreaResponsableRepository repository;
  ObtenerAreaResponsables(this.repository);
  Future<List<AreaResponsable>> ejecutar() => repository.obtenerAreaResponsables();
}
