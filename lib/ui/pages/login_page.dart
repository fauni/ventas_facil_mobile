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
  bool visible = false;
  
  @override
  void initState() {
    usernameController.text = 'faruni';
    passwordController.text = 'Inbolsa1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authService: AuthService()),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeroMode(
                    enabled: true,
                    child: Hero(
                      tag: 'heroIcono',
                      child: Image.asset(
                        'assets/icons/tomatefacilbanner.jpg',
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<LoginBloc, LoginState>(
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
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Bienvenido a:', 
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/icons/icono-logo.png'
                          ),
                        ),
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Nombre de Usuario',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )  
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  visible = !visible;
                                });
                              }, 
                              icon: visible 
                                ? const Icon(Icons.visibility_off) 
                                : const Icon(Icons.visibility)
                            ),
                            labelText: 'Contraseña',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          obscureText: !visible,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Aqui cambiar el idCompany por el que corresponda
                            loginData.idCompany = 1;
                            loginData.userName = usernameController.text;
                            loginData.passwordHash = passwordController.text;
                                  
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginButtonPressed(data: loginData)
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            )
                          ),
                          label: const Text('INICIAR SESIÓN'),
                          icon: const Icon(Icons.login),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}