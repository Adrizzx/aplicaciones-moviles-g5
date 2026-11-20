class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String tipo;
  final String rol;

  Usuario({required this.id, required this.nombre, required this.correo,
    required this.tipo, required this.rol});

  bool get esAdministrador => rol == 'administrador';
}
