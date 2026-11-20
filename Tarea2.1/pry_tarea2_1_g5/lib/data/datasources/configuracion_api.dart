import 'package:flutter/foundation.dart';

class ConfiguracionApi {
  // Emulador Android: 10.0.2.2 apunta al equipo donde corre JSON Server.
  // Windows/web: localhost. Teléfono físico: reemplazar por IP de la PC.
  static String get urlBase => kIsWeb ? 'http://localhost:3000'
      : defaultTargetPlatform == TargetPlatform.android
          ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
