
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/serie_numeracion/serie_numeracion.dart';

class SerieNumeracionRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<SerieNumeracion>> getSeriesNumeracionPorDocumento(String sessionID, int codigo) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/DocumentSeries/$codigo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<SerieNumeracion> series = jsonData.map((item) => SerieNumeracion.fromJson(item)).toList();
        if(series.isEmpty){
          throw GenericEmptyException();
        }
        return series;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } else {
        throw FetchDataException('Error al recuperar las series de numeración: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}