
import 'dart:convert';
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/models/venta/socio_negocio.dart';

class SocioNegocioRepository {
  final String _baseUrl = Environment.UrlApi;
  Future<List<SocioNegocio>> getAllSocioNegocio(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/BusinessPartners'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<SocioNegocio> clientes = jsonData.map((item) => SocioNegocio.fromJson(item)).toList();
        if(clientes.isEmpty){
          throw GenericEmptyException();
        }
        return clientes;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los Socios de Negocio: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<SocioNegocio> getSocioNegocioByCodigo(String sessionID, SocioNegocio data) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/BusinessPartners/${data.codigoSn}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        SocioNegocio cliente = SocioNegocio.fromJson(jsonData);
        return cliente;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los datos del Socio de Negocio: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}