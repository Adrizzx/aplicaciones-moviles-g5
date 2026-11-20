import 'package:flutter_test/flutter_test.dart';
import 'package:pry_tarea2_1_g5/data/models/incidencia_model.dart';
import 'package:pry_tarea2_1_g5/domain/entities/incidencia.dart';
import 'package:pry_tarea2_1_g5/domain/repositories/incidencia_repository.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/actualizar_incidencia.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/crear_incidencia.dart';

class RepositorioIncidenciasPrueba implements IncidenciaRepository {
  Incidencia? guardada;

  @override
  Future<List<Incidencia>> obtenerIncidencias() async => [];

  @override
  Future<Incidencia> crearIncidencia(Incidencia incidencia) async {
    guardada = incidencia;
    return incidencia;
  }

  @override
  Future<Incidencia> actualizarIncidencia(Incidencia incidencia) async {
    guardada = incidencia;
    return incidencia;
  }
}

Incidencia incidenciaDePrueba({String estado = 'Reportada',
    String? prioridad, String? areaId, String observacion = ''}) => Incidencia(
  id: '1', usuarioId: 'usuario', titulo: 'Falla', descripcion: 'Detalle',
  ubicacion: 'Aula', fecha: DateTime.utc(2026), prioridad: prioridad,
  estado: estado, areaId: areaId, observacionSolucion: observacion);

void main() {
  test('crear conserva fecha visible, estado y prioridad sin clasificar', () async {
    final repositorio = RepositorioIncidenciasPrueba();
    final fechaReporte = DateTime.utc(2026);
    final creada = await CrearIncidencia(repositorio).ejecutar(
      incidenciaDePrueba(prioridad: 'Alta', areaId: '1'));
    expect(creada.prioridad, isNull);
    expect(creada.estado, 'Reportada');
    expect(creada.areaId, isNull);
    expect(creada.fecha, fechaReporte);
  });

  test('modelo conserva la prioridad nula en JSON', () {
    final modelo = IncidenciaModel.desdeEntidad(incidenciaDePrueba());
    expect(modelo.toJson()['prioridad'], isNull);
    expect(IncidenciaModel.fromJson(modelo.toJson()).prioridad, isNull);
    expect(modelo.prioridadVisible, 'Pendiente de clasificación');
  });

  test('asignar área cambia estado y guarda ambos datos juntos', () async {
    final repositorio = RepositorioIncidenciasPrueba();
    final actualizada = await ActualizarIncidencia(repositorio).ejecutar(
      incidenciaDePrueba(), prioridad: null, estado: 'Reportada',
      areaId: '2', observacionSolucion: 'borrador');
    expect(actualizada.estado, 'Asignada');
    expect(actualizada.areaId, '2');
    expect(actualizada.observacionSolucion, isEmpty);
  });

  test('en proceso exige área y prioridad válida', () async {
    final caso = ActualizarIncidencia(RepositorioIncidenciasPrueba());
    final asignada = incidenciaDePrueba(estado: 'Asignada', areaId: '2');
    await expectLater(caso.ejecutar(asignada, prioridad: null,
      estado: 'En proceso', areaId: '2', observacionSolucion: ''), throwsException);
    await expectLater(caso.ejecutar(asignada, prioridad: 'Alta',
      estado: 'En proceso', observacionSolucion: ''), throwsException);
    final proceso = await caso.ejecutar(asignada, prioridad: 'Crítica',
      estado: 'En proceso', areaId: '2', observacionSolucion: '');
    expect(proceso.estado, 'En proceso');
  });

  test('resolución exige observación y cierre conserva la solución', () async {
    final caso = ActualizarIncidencia(RepositorioIncidenciasPrueba());
    final proceso = incidenciaDePrueba(estado: 'En proceso',
      prioridad: 'Alta', areaId: '2');
    await expectLater(caso.ejecutar(proceso, prioridad: 'Alta',
      estado: 'Resuelta', areaId: '2', observacionSolucion: '  '), throwsException);
    final resuelta = await caso.ejecutar(proceso, prioridad: 'Alta',
      estado: 'Resuelta', areaId: '2', observacionSolucion: '  Reparada  ');
    expect(resuelta.observacionSolucion, 'Reparada');
    final cerrada = await caso.ejecutar(resuelta, prioridad: 'Alta',
      estado: 'Cerrada', areaId: '2', observacionSolucion: '');
    expect(cerrada.observacionSolucion, 'Reparada');
    await expectLater(caso.ejecutar(cerrada, prioridad: 'Alta',
      estado: 'Cerrada', areaId: '2', observacionSolucion: ''), throwsException);
  });

  test('no permite omitir estados', () async {
    final caso = ActualizarIncidencia(RepositorioIncidenciasPrueba());
    await expectLater(caso.ejecutar(incidenciaDePrueba(), prioridad: 'Alta',
      estado: 'En proceso', areaId: '2', observacionSolucion: ''), throwsException);
    await expectLater(caso.ejecutar(incidenciaDePrueba(
      estado: 'Asignada', prioridad: 'Alta', areaId: '2'), prioridad: 'Alta',
      estado: 'Resuelta', areaId: '2', observacionSolucion: 'Lista'), throwsException);
    await expectLater(caso.ejecutar(incidenciaDePrueba(
      estado: 'En proceso', prioridad: 'Alta', areaId: '2'), prioridad: 'Alta',
      estado: 'Cerrada', areaId: '2', observacionSolucion: 'Lista'), throwsException);
  });
}
