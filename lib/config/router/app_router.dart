import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/pages/home_page.dart';
import 'package:ventas_facil/ui/pages/item/item_page.dart';
import 'package:ventas_facil/ui/pages/login_page.dart';
import 'package:ventas_facil/ui/pages/modulo_page.dart';
import 'package:ventas_facil/ui/pages/pedido/empleado_venta_page.dart';
import 'package:ventas_facil/ui/pages/pedido/line_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/nuevo_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedido_page.dart';
import 'package:ventas_facil/ui/pages/producto_page.dart';
import 'package:ventas_facil/ui/pages/socio_negocio/socio_negocio_page.dart';
import 'package:ventas_facil/ui/pages/usuarios_page.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/Modulos',
      builder: (context, state) => const ModuloPage(),
    ),
    GoRoute(
      path: '/Usuarios',
      builder: (context, state) => const UsuariosPage(),
    ),
    GoRoute(
      path: '/Login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/Productos',
      builder: (context, state) => const ProductoPage(),
    ),
    GoRoute(
      path: '/Items',
      builder: (context, state) {
        SocioNegocio data = state.extra as SocioNegocio;
        return ItemPage(socioNegocio: data,);
      },
    ),
    GoRoute(
      path: '/Pedidos',
      builder: (context, state) => const PedidoPage(),
    ),
    GoRoute(
      path: '/NuevoPedido',
      builder: (context, state) => const NuevoPedidoPage(),
    ),
    GoRoute(
      path: '/LineaDetallePedido',
      builder: (context, state) {
        SocioNegocio data = state.extra as SocioNegocio;
        return LinePedidoPage(socioNegocio: data,);
      } 
    ),
    GoRoute(
      path: '/EmpleadoVentas',
      builder: (context, state) {
        EmpleadoVenta data = state.extra as EmpleadoVenta;
        return EmpleadoVentaPage(empleadoSeleccionado: data,);
      },
    ),
    GoRoute(
      path: '/SocioNegocio',
      builder: (context, state) {
        SocioNegocio data = state.extra as SocioNegocio;
        return SocioNegocioPage(clienteSeleccionado: data,);
      },
    ),
    
  ]
);