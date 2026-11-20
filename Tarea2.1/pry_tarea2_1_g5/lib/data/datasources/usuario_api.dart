import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario_model.dart';
import 'configuracion_api.dart';

class UsuarioApi {
  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final respuesta = await http.get(Uri.parse('${ConfiguracionApi.urlBase}/usuarios'));
    if (respuesta.statusCode != 200) throw Exception('Error al obtener usuarios: ${respuesta.statusCode}');
    return (jsonDecode(respuesta.body) as List)
      .map((dato) => UsuarioModel.fromJson(dato as Map<String, dynamic>)).toList();
  }

  // Inicio de sesión SOLO para demostración: JSON Server no autentica ni protege rutas.
  // Nunca se debe usar esta estrategia con contraseñas reales.
  Future<UsuarioModel?> iniciarSesion(String correo, String contrasena) async {
    final uri = Uri.parse('${ConfiguracionApi.urlBase}/usuarios')
        .replace(queryParameters: {'correo': correo.trim().toLowerCase()});
    final respuesta = await http.get(uri);
    if (respuesta.statusCode != 200) throw Exception('No se pudo conectar con el servidor');
    final registros = jsonDecode(respuesta.body) as List;
    if (registros.isEmpty) return null;
    final datos = registros.first as Map<String, dynamic>;
    if (datos['contrasena'] != contrasena) return null;
    return UsuarioModel.fromJson(datos);
  }
}
