import 'package:flutter/material.dart';

import '../vistas/pantallas/pantalla_comprobante.dart';
import '../vistas/pantallas/pantalla_login.dart';
import '../vistas/pantallas/pantalla_recarga.dart';

/// Rutas con nombre de la aplicación.
class AppRoutes {
  static const String login = '/';
  static const String recarga = '/recarga';
  static const String comprobante = '/comprobante';

  static Map<String, WidgetBuilder> rutas = {
    login: (context) => const LoginScreen(),
    recarga: (context) => const RecargaScreen(),
    comprobante: (context) => const ComprobanteScreen(),
  };
}
