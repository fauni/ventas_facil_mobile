import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/login_bloc/login_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_state.dart';
import 'package:ventas_facil/bloc/usuario_bloc/usuario_bloc.dart';
import 'package:ventas_facil/config/router/app_router.dart';
import 'package:ventas_facil/config/theme/app_theme.dart';
import 'package:ventas_facil/database/database_provider.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/repository/usuarios_repository.dart';
import 'package:ventas_facil/services/auth_service.dart';
import 'package:ventas_facil/services/usuario_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioService = UsuarioService();
    final databaseProvider = DatabaseProvider.dbProvider;
    final usuariosRepository = UsuariosRepository(usuarioService, databaseProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(),),
        BlocProvider(create: (context) => UsuarioBloc(usuariosRepository),),
        BlocProvider(create: (context) => LoginBloc(authService: AuthService(),),),
      ], 
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Ventas Facil',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: !state.isDark 
            ? ThemeData(
              brightness: Brightness.light
            )
            : ThemeData(
              brightness: Brightness.dark
            ),
          );
        },
      )
    );
  }
}