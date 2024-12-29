
import 'dart:convert';
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/producto/producto.dart';

import 'package:http/http.dart' as http;

class ProductoRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<Producto>> getAllProductos(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/Items'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<Producto> productos = jsonData.map((item) => Producto.fromJson(item)).toList();
        if(productos.isEmpty){
          throw ProductsEmptyException();
        }
        return productos;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los productos: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}