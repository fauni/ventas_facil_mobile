// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:ventas_facil/config/constants/environment.dart';

// import 'package:ventas_facil/models/authentication/login.dart';
// import 'package:ventas_facil/models/authentication/user.dart';

class AuthRepository {
  // final String _baseUrl = Environment.UrlApi;
  // Future<User> login(Login data) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/User/Login'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data)
  //   );

  //   if(response.statusCode == 200){
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('asd El usuario o contraseña es incorrecto');
  //   }
  // }
}