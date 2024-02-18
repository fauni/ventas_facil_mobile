import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/login_bloc/login_event.dart';
import 'package:ventas_facil/bloc/login_bloc/login_state.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/services/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthService authService;

  LoginBloc({ required this.authService }) : super(LoginInitial()){
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final User user = await authService.login(event.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user));
        await prefs.setString('token', user.apiToken!);
        emit(LoginSuccess(user: user));
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}
