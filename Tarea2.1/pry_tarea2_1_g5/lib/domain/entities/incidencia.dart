class Incidencia {
  final String? id;
  final String usuarioId;
  final String titulo;
  final String descripcion;
  final String ubicacion;
  final DateTime fecha;
  final String? prioridad;
  final String estado;
  final String? areaId;
  final String observacionSolucion;

  Incidencia({required this.id, required this.usuarioId, required this.titulo,
    required this.descripcion, required this.ubicacion, required this.fecha,
    this.prioridad, required this.estado, this.areaId,
    required this.observacionSolucion});

  static const prioridades = ['Baja', 'Media', 'Alta', 'Crítica'];
  static const estados = ['Reportada', 'Asignada', 'En proceso', 'Resuelta', 'Cerrada'];
  String get prioridadVisible => prioridad ?? 'Pendiente de clasificación';

  Incidencia copiar({String? prioridad, String? estado, String? areaId,
    String? observacionSolucion}) => Incidencia(
    id: id, usuarioId: usuarioId, titulo: titulo, descripcion: descripcion,
    ubicacion: ubicacion, fecha: fecha, prioridad: prioridad ?? this.prioridad,
    estado: estado ?? this.estado, areaId: areaId ?? this.areaId,
    observacionSolucion: observacionSolucion ?? this.observacionSolucion);
}
