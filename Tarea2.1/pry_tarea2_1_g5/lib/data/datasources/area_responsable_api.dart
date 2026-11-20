import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/area_responsable_model.dart';
import 'configuracion_api.dart';

class AreaResponsableApi {
  Future<List<AreaResponsableModel>> obtenerAreaResponsables() async {
    final respuesta = await http.get(Uri.parse('${ConfiguracionApi.urlBase}/areas'));
    if (respuesta.statusCode != 200) throw Exception('Error al obtener areas: ${respuesta.statusCode}');
    final lista = jsonDecode(respuesta.body) as List;
    return lista.map((json) => AreaResponsableModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
