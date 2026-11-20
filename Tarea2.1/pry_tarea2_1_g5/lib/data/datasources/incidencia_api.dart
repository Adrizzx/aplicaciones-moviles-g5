import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/incidencia_model.dart';
import 'configuracion_api.dart';

class IncidenciaApi {
  String get url => '${ConfiguracionApi.urlBase}/incidencias';

  Future<List<IncidenciaModel>> obtenerIncidencias() async {
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode != 200) throw Exception('Error al obtener incidencias: ${respuesta.statusCode}');
    final lista = jsonDecode(respuesta.body) as List;
    return lista.map((dato) => IncidenciaModel.fromJson(dato as Map<String, dynamic>)).toList();
  }

  Future<IncidenciaModel> crearIncidencia(IncidenciaModel incidencia) async {
    final respuesta = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(incidencia.toJson()));
    if (respuesta.statusCode != 201 && respuesta.statusCode != 200) {
      throw Exception('Error al crear incidencia: ${respuesta.statusCode}');
    }
    return IncidenciaModel.fromJson(jsonDecode(respuesta.body) as Map<String, dynamic>);
  }

  Future<IncidenciaModel> actualizarIncidencia(IncidenciaModel incidencia) async {
    if (incidencia.id == null) throw Exception('La incidencia no tiene identificador');
    final respuesta = await http.put(Uri.parse('$url/${incidencia.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(incidencia.toJson()));
    if (respuesta.statusCode != 200) {
      throw Exception('Error al actualizar incidencia: ${respuesta.statusCode}');
    }
    return IncidenciaModel.fromJson(jsonDecode(respuesta.body) as Map<String, dynamic>);
  }
}
