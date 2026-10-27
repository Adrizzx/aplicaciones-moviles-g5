import '../modelos/modelo_usuario.dart';

/// CONTROLADOR: validaciones e inicio de sesión.
class LoginController {
  // Usuario de prueba (no hay base de datos)
  final UsuarioModel _usuarioValido =
      const UsuarioModel(usuario: 'admin', contrasena: '1234');

  String? validarUsuario(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Ingrese el usuario';
    }
    if (valor.trim().length < 4) {
      return 'El usuario debe tener al menos 4 caracteres';
    }
    return null;
  }

  String? validarContrasena(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Ingrese la contraseña';
    }
    if (valor.length < 4) {
      return 'La contraseña debe tener al menos 4 caracteres';
    }
    return null;
  }

  bool iniciarSesion(String usuario, String contrasena) {
    return usuario.trim() == _usuarioValido.usuario &&
        contrasena == _usuarioValido.contrasena;
  }
}
