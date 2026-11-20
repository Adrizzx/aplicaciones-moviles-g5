import '../entities/area_responsable.dart';
abstract class AreaResponsableRepository {
  Future<List<AreaResponsable>> obtenerAreaResponsables();
}
