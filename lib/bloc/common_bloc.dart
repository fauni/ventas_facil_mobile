import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/bloc/login_bloc/login_bloc.dart';
import 'package:ventas_facil/database/database_provider.dart';
import 'package:ventas_facil/repository/condicion_pago_repository.dart';
import 'package:ventas_facil/repository/item_repository.dart';
import 'package:ventas_facil/repository/item_unidad_medida_repository.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';
import 'package:ventas_facil/repository/producto_repository.dart';
import 'package:ventas_facil/repository/sales_employee_repository.dart';
import 'package:ventas_facil/repository/serie_numeracion_repository.dart';
import 'package:ventas_facil/repository/socio_negocio_repository.dart';
import 'package:ventas_facil/repository/usuarios_repository.dart';
import 'package:ventas_facil/services/auth_service.dart';
import 'package:ventas_facil/services/usuario_service.dart';

class CommonBloc {
  static final themeBloc = ThemeBloc();
  static final usuarioBloc = UsuarioBloc(UsuariosRepository(UsuarioService(), DatabaseProvider.dbProvider));
  static final loginBloc = LoginBloc(authService: AuthService());
  static final productoBloc = ProductoBloc(ProductoRepository());
  static final pedidoBloc = PedidoBloc(PedidoRepository());
  static final pedidoPendienteBloc = PedidoPendienteBloc(PedidoRepository());
  static final salesEmployeelBloc = SalesEmployeeBloc(SalesEmployeeRepository());
  static final socioNegocioBloc = SocioNegocioBloc(SocioNegocioRepository());
  static final itemBloc = ItemBloc(ItemRepository());
  static final itemUnidadMedidaBloc = UnidadMedidaBloc(ItemUnidadMedidaRepository());
  static final condicionPagoBloc = CondicionPagoBloc(CondicionPagoRepository());
  static final serieNumeracionBloc = SerieNumeracionBloc(SerieNumeracionRepository());


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
    ),
    BlocProvider<PedidoPendienteBloc>(
      create: (context) => pedidoPendienteBloc,
    ),
    BlocProvider<SalesEmployeeBloc>(
      create: (context) => salesEmployeelBloc,
    ),
    BlocProvider<SocioNegocioBloc>(
      create: (context) => socioNegocioBloc,
    ),
    BlocProvider<UnidadMedidaBloc>(
      create: (context) => itemUnidadMedidaBloc,
    ),
    BlocProvider<ItemBloc>(
      create: (context) => itemBloc,
    ),
    BlocProvider<CondicionPagoBloc>(
      create: (context) => condicionPagoBloc,
    ),
    BlocProvider<SerieNumeracionBloc>(
      create: (context) => serieNumeracionBloc,
    )
  ];

  // Dispose
  static void dispose(){
    themeBloc.close();
    usuarioBloc.close();
    loginBloc.close();
    productoBloc.close();
    pedidoBloc.close();
    pedidoPendienteBloc.close();
    salesEmployeelBloc.close();
    socioNegocioBloc.close();
    itemUnidadMedidaBloc.close();
    itemBloc.close();
    condicionPagoBloc.close();
    serieNumeracionBloc.close();
  }

  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }

  CommonBloc._internal();
}