import '../entities/usuario.dart';
abstract class UsuarioRepository {
  Future<List<Usuario>> obtenerUsuarios();
  Future<Usuario?> iniciarSesion(String correo, String contrasena);
}
