import 'package:ventas_facil/models/authentication/login.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final Login data;
  
  LoginButtonPressed({ required this.data });
}