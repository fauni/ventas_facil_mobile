import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/login_bloc/login_bloc.dart';
import 'package:ventas_facil/bloc/login_bloc/login_event.dart';
import 'package:ventas_facil/bloc/login_bloc/login_state.dart';
import 'package:ventas_facil/models/authentication/login.dart';

class LoginDialogWidget {
  static void mostrarDialogLogin(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        TextEditingController usernameController = TextEditingController();
        TextEditingController passwordController = TextEditingController();
        return BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess){
              context.pop();
              ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Se autentifico correctamente.'), backgroundColor: Colors.green,));
            }
            if(state is LoginFailure){
              ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Usuario o contraseña incorrecta!'), backgroundColor: Colors.red,));
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Autentificarse'),
              actions: [
                if(state is! LoginLoading) ...[
                  ElevatedButton.icon(
                    onPressed: () {
                      Login loginData = Login();
                      loginData.idCompany = 1;
                      loginData.userName = usernameController.text;
                      loginData.passwordHash= passwordController.text;
                      loginBloc.add(LoginButtonPressed(data: loginData));
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Iniciar Sesión'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Salir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ],
              content: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Nombre de Usuario',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}
