import '../entities/usuario.dart';
import '../repositories/usuario_repository.dart';
class ObtenerUsuarios {
  final UsuarioRepository repository;
  ObtenerUsuarios(this.repository);
  Future<List<Usuario>> ejecutar() => repository.obtenerUsuarios();
}
