import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

class PedidoRepository {
  final String _baseUrl = Environment.UrlApi;
  Future<Pedido> guardarPedido(String sessionID, Pedido data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/Orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        },
        body: jsonEncode(data)
      );
      if(response.statusCode == 200){
        return Pedido.fromJson(jsonDecode(response.body));
      } else if(response.statusCode == 401) {
        throw UnauthorizedException();
      }
      else {
        throw FetchDataException('Error al guardar: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al guardar el pedido: $e');
    }
  }

  Future<List<PedidoList>> getOrdenesVentaAbiertos(String sessionID) async {
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