import '../../domain/entities/incidencia.dart';

class IncidenciaModel extends Incidencia {
  IncidenciaModel({required super.id, required super.usuarioId, required super.titulo,
    required super.descripcion, required super.ubicacion, required super.fecha,
    super.prioridad, required super.estado, super.areaId,
    required super.observacionSolucion});

  factory IncidenciaModel.fromJson(Map<String, dynamic> json) => IncidenciaModel(
    id: json['id']?.toString(), usuarioId: json['usuarioId']?.toString() ?? '',
    titulo: json['titulo']?.toString() ?? '', descripcion: json['descripcion']?.toString() ?? '',
    ubicacion: json['ubicacion']?.toString() ?? '',
    fecha: DateTime.tryParse(json['fecha']?.toString() ?? '') ?? DateTime.now(),
    prioridad: json['prioridad']?.toString(),
    estado: json['estado']?.toString() ?? 'Reportada',
    areaId: json['areaId']?.toString(),
    observacionSolucion: json['observacionSolucion']?.toString() ?? '');

  factory IncidenciaModel.desdeEntidad(Incidencia i) => IncidenciaModel(
    id: i.id, usuarioId: i.usuarioId, titulo: i.titulo, descripcion: i.descripcion,
    ubicacion: i.ubicacion, fecha: i.fecha, prioridad: i.prioridad, estado: i.estado,
    areaId: i.areaId, observacionSolucion: i.observacionSolucion);

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'usuarioId': usuarioId, 'titulo': titulo, 'descripcion': descripcion,
    'ubicacion': ubicacion, 'fecha': fecha.toUtc().toIso8601String(),
    'prioridad': prioridad, 'estado': estado, 'areaId': areaId,
    'observacionSolucion': observacionSolucion};
}
