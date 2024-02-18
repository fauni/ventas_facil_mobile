import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ventas_facil/models/authentication/login.dart';
import 'package:ventas_facil/models/authentication/user.dart';

class AuthRepository {
  Future<User> login(Login data) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.102:9096/api/User/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data)
    );

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('El usuario o contraseña es incorrecto');
    }
  }
}