import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/config/helpers/helpers.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/pedido/update_status_item_order.dart';
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
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        throw Exception('${errorSap.message}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> guardarPedido2(String sessionID, Pedido data) async {
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
        return true;
      } else if(response.statusCode == 401) {
        throw UnauthorizedException();
      }
      else {
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        throw Exception('${errorSap.message}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<PedidoList>> getOrdenesVentaAbiertos(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/Orders?top=5&skip=0'),
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
        throw FetchDataException('${response.statusCode}');
      }
    } catch(e){
      throw Exception('$e');
    }
  }

  Future<List<PedidoList>> getOrdenesForSearch(String sessionID, String search) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/Orders?top=5&skip=0&search=$search'),
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
        throw FetchDataException('${response.statusCode}');
      }
    } catch(e){
      throw Exception('$e');
    }
  }

  Future<bool> modificarPedido(String sessionID, Pedido data) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/Orders/${data.codigoSap}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        },
        body: jsonEncode(data)
      );
      if(response.statusCode == 200){
        return true;
      } else if(response.statusCode == 401) {
        throw UnauthorizedException();
      }
      else {
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        throw Exception('${errorSap.message}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> modificarEstadoLineaPedido(String sessionID, Pedido data, ItemPedido item) async {
    UpdateStatusItemOrder order = UpdateStatusItemOrder();
    List<LinesPedido> lines = [];
    for (var element in data.linesPedido) {
      if (item.numeroDeLinea == element.numeroDeLinea){
        lines.add(LinesPedido(numeroDeLinea: element.numeroDeLinea));
      }
    }
    order.id = data.id;
    order.codigoSap = data.codigoSap;
    order.linesPedido = lines;


    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/Orders/modificarEstadoLinea/${data.codigoSap}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        },
        body: jsonEncode(order)
      );
      if(response.statusCode == 200){
        return true;
      } else if(response.statusCode == 401) {
        throw UnauthorizedException();
      }
      else {
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        throw Exception('${errorSap.message}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Generar reporte del Pedido
  Future<String> downloadReport(String sessionID, int id) async {

    var response = await http.get(
      Uri.parse('$_baseUrl/Orders/GenerarReporte/$id'),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
      },
    );
    
    if(response.statusCode == 200){
      var documentDirectory = await getApplicationDocumentsDirectory();
      var filePath = '${documentDirectory.path}/pedido-$id.pdf';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else if(response.statusCode == 401) {
      throw UnauthorizedException();
    }
    else {
      final errorData = jsonDecode(response.body);
      final errorSap = Helper.getErrorSap(errorData);
      throw Exception('${errorSap.message}');
    }
  }

  Future<Uint8List?> fetchReportePDF(String sessionID, int id) async {
    try {
      var response = await http.get(
        Uri.parse('$_baseUrl/Orders/GenerarReporte/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID,
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access');
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception('Error from SAP: ${errorData['message']}');
      }
    } catch (e) {
      print('Error fetching PDF: $e');
      return null;
    }
  }

  // region: PEDIDOS PENDIENTES DE APROBACIÓN
  Future<List<PedidoList>> getOrdenesPendientesAprobacion(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/OrdersPending?top=5&skip=0'),
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
        throw FetchDataException('${response.statusCode}');
      }
    } catch(e){
      throw Exception('$e');
    }
  }

  Future<List<PedidoList>> getOrdenesPendientesAprobacionBySearch(String sessionID, String search) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/OrdersPending?top=5&skip=0&search=$search'),
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
        throw FetchDataException('${response.statusCode}');
      }
    } catch(e){
      throw Exception('$e');
    }
  }

  // region: PEDIDOS PENDIENTES DE APROBACIÓN
  Future<List<PedidoList>> getOrdenesPendientesAprobados(String sessionID, String search) async {
    try {
      final response = search.isEmpty
      ? await http.get(
        Uri.parse('$_baseUrl/OrdersPending/Aprobados?top=5&skip=0'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      )
      : await http.get(
        Uri.parse('$_baseUrl/OrdersPending/Aprobados?top=5&skip=0&search=$search'),
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
        throw FetchDataException('${response.statusCode}');
      }
    } catch(e){
      throw Exception('$e');
    }
  }

  // Crear documento aprobado
  Future<bool> crearDocumentoAprobado(String sessionID, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/OrdersPending/CrearDocumento/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': sessionID
        }
      );
      if(response.statusCode == 200){
        return true;
      } else if(response.statusCode == 401) {
        throw UnauthorizedException();
      }
      else {
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        throw Exception('${errorSap.message}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}