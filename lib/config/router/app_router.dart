import 'package:go_router/go_router.dart';
import 'package:ventas_facil/ui/pages/home_page.dart';
import 'package:ventas_facil/ui/pages/login_page.dart';
import 'package:ventas_facil/ui/pages/producto_page.dart';
import 'package:ventas_facil/ui/pages/usuarios_page.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
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
  ]
);