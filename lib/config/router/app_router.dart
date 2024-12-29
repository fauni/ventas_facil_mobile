import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/pages/condicion_pago/condicion_pago_page.dart';
import 'package:ventas_facil/ui/pages/home_page.dart';
import 'package:ventas_facil/ui/pages/item/item_page.dart';
import 'package:ventas_facil/ui/pages/login_page.dart';
import 'package:ventas_facil/ui/pages/modulo_page.dart';
import 'package:ventas_facil/ui/pages/pedido/detalle_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/empleado_venta_page.dart';
import 'package:ventas_facil/ui/pages/pedido/line_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/nuevo_pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedido_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedidos_autorizados_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedidos_pendientes_page.dart';
import 'package:ventas_facil/ui/pages/pedido/persona_contacto_page.dart';
import 'package:ventas_facil/ui/pages/producto_page.dart';
import 'package:ventas_facil/ui/pages/serie_numeracion/serie_numeracion_page.dart';
import 'package:ventas_facil/ui/pages/serie_numeracion/serie_numeracion_user_page.dart';
import 'package:ventas_facil/ui/pages/socio_negocio/socio_negocio_page.dart';
import 'package:ventas_facil/ui/pages/usuarios_page.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero
            ).animate(animation),
            child: child,
          );
        },
      ),
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
      path: '/PedidosPendientes',
      builder: (context, state) => const PedidosPendientesPage(),
    ),
    GoRoute(
      path: '/PedidosAutorizados',
      builder: (context, state) => const PedidosAutorizadosPage(),
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
      builder: (context, state){
        Pedido data = state.extra as Pedido;
        return NuevoPedidoPage(pedido: data,);
      },
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
    GoRoute(
      path: '/CondicionPago',
      builder: (context, state) {
        int id = state.extra as int;
        return CondicionPagoPage(idCondicionSeleccionado: id);
      },
    ),
    GoRoute(
      path: '/SerieNumeracion',
      builder: (context, state) {
        String id = state.extra as String;
        return SerieNumeracionPage(serieSeleccionada: id);
      },
    ),
    GoRoute(
      path: '/SerieNumeracionUsuario/:serieSeleccionada',
      builder: (context, state) {
        // Recuperamos el parámetro desde pathParameters
        final String serieSeleccionada = state.pathParameters['serieSeleccionada'] ?? '';
        
        // Recuperamos la lista de series desde `extra`
        final List<UserSerie> series = state.extra as List<UserSerie>;
        return SerieNumeracionUserPage(
          serieSeleccionada: serieSeleccionada,
          series: series,
        );
      },
    )
  ]
);