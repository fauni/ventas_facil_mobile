import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/models/authentication/user.dart';


Future<bool> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  return true;
}

// void setCurrentUser(jsonString) async {
//   try {
//     if (json.decode(jsonString)['data'] != null) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
//     }
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: jsonString).toString());
//     throw new Exception(e);
//   }
// }


Future<User> getCurrentUser() async {
  User user = User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userString = prefs.getString('user');

  if(userString != null){
    try {
      final Map<String, dynamic> userMap = jsonDecode(userString);
      user = User.fromJson(userMap);
    } catch(e){
      user = User();
    }
  } else {

  }
  return user;
}
