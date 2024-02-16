import 'package:ventas_facil/models/authentication/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({ required this.user });
}