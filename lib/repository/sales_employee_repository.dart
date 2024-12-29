
import 'dart:convert';
import 'package:ventas_facil/config/constants/environment.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';

import 'package:http/http.dart' as http;

class SalesEmployeeRepository {
  final String _baseUrl = Environment.UrlApi;
  final String _databaseSelector = Environment.databaseSelector;

  Future<List<EmpleadoVenta>> getAllEmpleados(String sessionID) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/SalesPerson'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<EmpleadoVenta> empleados = jsonData.map((item) => EmpleadoVenta.fromJson(item)).toList();
        if(empleados.isEmpty){
          throw GenericEmptyException();
        }
        return empleados;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los Empleados: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<EmpleadoVenta> getEmpleadoById(String sessionID, EmpleadoVenta empleado) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/SalesPerson/${empleado.codigoEmpleado}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Database-Identifier': _databaseSelector,
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        EmpleadoVenta empleado = EmpleadoVenta.fromJson(jsonData);
        return empleado;
      } else if(response.statusCode == 401){
        throw UnauthorizedException();
      } 
      else {
        throw FetchDataException('Error al recuperar los datos del Empleado: Estado ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }
}