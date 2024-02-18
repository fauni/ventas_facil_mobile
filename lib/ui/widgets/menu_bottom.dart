// import 'package:flutter/material.dart';
// import 'package:ventas_facil/ui/pages/home_page.dart';
// import 'package:ventas_facil/ui/pages/producto_page.dart';
// import 'package:ventas_facil/ui/pages/usuarios_page.dart';

// class MenuBottom extends StatefulWidget {
//   const MenuBottom({
//     Key? key,
//   }): super(key: key);

//   @override
//   State<MenuBottom> createState() => _MenuBottomState();
// }

// class _MenuBottomState extends State<MenuBottom> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     HomePage(),
//     UsuariosPage(),
//     ProductoPage(),
//   ];

//   void _onItemTapped(int index){
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Buscar',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications),
//           label: 'Notificaciones',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle),
//           label: 'Perfil',
//         ),
//       ],
//       currentIndex: widget.selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: widget.onItemTaped,
//     );
//   }
// }