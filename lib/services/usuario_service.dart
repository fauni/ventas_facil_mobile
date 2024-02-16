import 'dart:convert';

import 'package:ventas_facil/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _baseUrl = 'http://192.168.0.102:9095/api';
  Future<List<Usuario>> fetchUsuarios() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/User'));
      if(response.statusCode == 200){
        final List<dynamic> usuariosJson = json.decode(response.body);
        return usuariosJson.map((json) => Usuario.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar usuarios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar al servidor: $e');
    }
  }
}