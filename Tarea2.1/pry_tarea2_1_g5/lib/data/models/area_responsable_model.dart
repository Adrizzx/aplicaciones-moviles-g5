import '../../domain/entities/area_responsable.dart';

class AreaResponsableModel extends AreaResponsable {
  AreaResponsableModel({required super.id, required super.nombre, required super.descripcion});

  factory AreaResponsableModel.fromJson(Map<String, dynamic> json) => AreaResponsableModel(
    id: json['id'].toString(), nombre: json['nombre']?.toString() ?? '',
    descripcion: json['descripcion']?.toString() ?? '');

  Map<String, dynamic> toJson() => {'id': id, 'nombre': nombre, 'descripcion': descripcion};
}
