import 'package:flutter/material.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/usecases/iniciar_sesion.dart';

class SesionViewModel extends ChangeNotifier {
  final IniciarSesion iniciarSesion;
  SesionViewModel(this.iniciarSesion);

  Usuario? usuarioActual;
  bool cargando = false;
  String error = '';
  bool get estaAutenticado => usuarioActual != null;
  bool get esAdministrador => usuarioActual?.esAdministrador ?? false;

  Future<bool> ingresar(String correo, String contrasena) async {
    cargando = true;
    error = '';
    notifyListeners();
    try {
      usuarioActual = await iniciarSesion.ejecutar(correo, contrasena);
      return true;
    } catch (e) {
      usuarioActual = null;
      error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      cargando = false;
      notifyListeners();
    }
  }

  void salir() {
    usuarioActual = null;
    error = '';
    notifyListeners();
  }
}
