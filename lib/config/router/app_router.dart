import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/pages/home_page.dart';
import 'package:ventas_facil/ui/pages/item/item_page.dart';
import 'package:ventas_facil/ui/pages/login_page.dart';
import 'package:ventas_facil/ui/pages/modulo_page.dart';
import 'package:ventas_facil/ui/pages/pedido/detalle_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/empleado_venta_page.dart';
import 'package:ventas_facil/ui/pages/pedido/line_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/nuevo_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/persona_contacto_page.dart';
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
      path: '/DetallePedido',
      builder: (context, state) {
        PedidoList data = state.extra as PedidoList;
        return DetallePedidoPage(pedido: data,);
      } 
    ),
    GoRoute(
      path: '/NuevoPedido',
      builder: (context, state) => const NuevoPedidoPage(),
    ),
    GoRoute(
      path: '/LineaDetallePedido',
      builder: (context, state) {
        Pedido data = state.extra as Pedido;
        return LinePedidoPage(pedido: data,);
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
    GoRoute(
      path: '/PersonaContacto',
      builder: (context, state) {
        SocioNegocio data = state.extra as SocioNegocio;
        return PersonaContactoPage(socioNegocio: data);
      },
    ),
  ]
);