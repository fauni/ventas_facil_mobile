import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/producto/item.dart';

class ItemRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<Item>> getAllItemsParaVenta(String sessionID, String text, {int top = 10, int skip = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/Items?text=$text&top=$top&skip=$skip'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<Item> items = jsonData.map((item) => Item.fromJson(item)).toList();
        if(items.isEmpty){
          throw GenericEmptyException();
        }
        return items;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los items: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}