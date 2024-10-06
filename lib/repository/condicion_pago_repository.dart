
import 'dart:convert';
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/models/condicion_pago/condicion_pago.dart';

class CondicionPagoRepository {
  final String _baseUrl = Environment.UrlApi;
  Future<List<CondicionDePago>> getAllCondicionDePago(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/PaymentTermsTypes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<CondicionDePago> data = jsonData.map((item) => CondicionDePago.fromJson(item)).toList();
        if(data.isEmpty){
          throw GenericEmptyException();
        }
        return data;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar las Condiciones de Pago: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<CondicionDePago> getCondicionDePagoPorId(String sessionID, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/PaymentTermsTypes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        CondicionDePago condicion = CondicionDePago.fromJson(jsonData);
        return condicion;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los datos: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}