import '../entities/usuario.dart';
import '../repositories/usuario_repository.dart';

class IniciarSesion {
  final UsuarioRepository repository;
  IniciarSesion(this.repository);

  Future<Usuario> ejecutar(String correo, String contrasena) async {
    if (correo.trim().isEmpty || contrasena.isEmpty) {
      throw Exception('Ingrese correo y contraseña');
    }
    final usuario = await repository.iniciarSesion(correo, contrasena);
    if (usuario == null) throw Exception('Credenciales incorrectas');
    if (usuario.rol != 'usuario' && usuario.rol != 'administrador') {
      throw Exception('Rol desconocido');
    }
    return usuario;
  }
}
