import 'dart:convert';

import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/unidad_,medida/tfe_unidad_medida.dart';
import 'package:http/http.dart' as http;

class UnidadMedidaRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<TfeUnidadMedida>> getAllUnidadMedida(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/UnidadMedida'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<TfeUnidadMedida> unidades = jsonData.map((item) => TfeUnidadMedida.fromJson(item)).toList();
        if(unidades.isEmpty){
          throw GenericEmptyException();
        }
        return unidades;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar las Unidades de Medida: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}