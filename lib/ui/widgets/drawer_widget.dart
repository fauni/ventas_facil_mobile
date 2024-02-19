import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/models/authentication/user.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? usuario;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> loadUserData());
  }

  Future<void> loadUserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString =  prefs.getString('user');
    if(userString != null){
      try {
        final Map<String, dynamic> userMap = jsonDecode(userString);
        setState(() {
          usuario = User.fromJson(userMap);
        });
      } catch (e) {
        context.go('/Login');
      }
    } else {
      context.go('/Login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: usuario == null ? const SizedBox() : UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1)
              ),
              accountName: Text(
                usuario!.userName!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              accountEmail: Text(
                usuario!.email!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(usuario!.userName![0].toUpperCase(), style: const TextStyle(fontSize: 30, color: Colors.white)),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 1);
            },
            leading: Icon(
              Icons.fastfood,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Pedidos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              context.push('/Productos');
            },
            leading: Icon(
              Icons.sanitizer_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Productos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Notifications');
            },
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Notificaciones',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              context.push('/Usuarios');
            },
            leading: Icon(
              Icons.person,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Usuarios',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              // logout().then((value) {
              //   Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
              // });
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Cerrar Sesión',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}