import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

class PedidoRepository {
  final String _baseUrl = 'http://192.168.0.102:9096/api';
  Future<List<PedidoList>> getAllVentas(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/Orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<PedidoList> orders = jsonData.map((item) => PedidoList.fromJson(item)).toList();
        if(orders.isEmpty){
          throw GenericEmptyException();
        }
        return orders;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los pedidos: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}