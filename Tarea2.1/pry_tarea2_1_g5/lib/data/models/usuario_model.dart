import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({required super.id, required super.nombre, required super.correo,
    required super.tipo, required super.rol});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
    id: json['id'].toString(), nombre: json['nombre']?.toString() ?? '',
    correo: json['correo']?.toString() ?? '',
    tipo: json['tipo']?.toString() ?? 'Estudiante',
    rol: json['rol']?.toString() ?? 'usuario');
}
