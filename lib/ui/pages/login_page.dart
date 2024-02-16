import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/login_bloc/login_bloc.dart';
import 'package:ventas_facil/bloc/login_bloc/login_event.dart';
import 'package:ventas_facil/bloc/login_bloc/login_state.dart';
import 'package:ventas_facil/models/authentication/login.dart';
import 'package:ventas_facil/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginData = Login();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authService: AuthService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess){
              context.go('/');
            } else if(state is LoginFailure){
              ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if(state is LoginLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Nombre de Usuario'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    loginData.idCompany = 1;
                    loginData.userName = usernameController.text;
                    loginData.passwordHash = passwordController.text;

                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(data: loginData)
                    );
                  }, 
                  child: const Text('Iniciar Sesión')
                )
              ],
            );
          },
        ),
      ),
    );
  }
}