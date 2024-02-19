import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/bloc/login_bloc/login_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_bloc.dart';
import 'package:ventas_facil/database/database_provider.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';
import 'package:ventas_facil/repository/producto_repository.dart';
import 'package:ventas_facil/repository/usuarios_repository.dart';
import 'package:ventas_facil/services/auth_service.dart';
import 'package:ventas_facil/services/usuario_service.dart';

class CommonBloc {
  static final themeBloc = ThemeBloc();
  static final usuarioBloc = UsuarioBloc(UsuariosRepository(UsuarioService(), DatabaseProvider.dbProvider));
  static final loginBloc = LoginBloc(authService: AuthService());
  static final productoBloc = ProductoBloc(ProductoRepository());
  static final pedidoBloc = PedidoBloc(PedidoRepository());

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<UsuarioBloc>(
      create: (context) => usuarioBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    BlocProvider<ProductoBloc>(
      create: (context) => productoBloc,
    ),
    BlocProvider<PedidoBloc>(
      create: (context) => pedidoBloc,
    )
  ];

  // Dispose
  static void dispose(){
    themeBloc.close();
    usuarioBloc.close();
    loginBloc.close();
    productoBloc.close();
  }

  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }

  CommonBloc._internal();
}