import '../../domain/entities/usuario.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../datasources/usuario_api.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioApi api;
  UsuarioRepositoryImpl(this.api);
  @override
  Future<List<Usuario>> obtenerUsuarios() => api.obtenerUsuarios();
  @override
  Future<Usuario?> iniciarSesion(String correo, String contrasena) =>
      api.iniciarSesion(correo, contrasena);
}
