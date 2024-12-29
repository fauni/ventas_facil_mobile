import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';

class UserSerieRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<UserSerie>> getUserSerieByUser(String idUsuario) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/UserSerie/GetSerieByUser/$idUsuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          // 'Cookie': sessionID
        }
      );
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<UserSerie> series = jsonData.map((item) => UserSerie.fromJson(item)).toList();
        if(series.isEmpty){
          throw GenericEmptyException();
        }
        return series;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } else {
        throw FetchDataException('Error al recuperar las series de usuario: Estado ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener las series de usuario');
    }
  }
}