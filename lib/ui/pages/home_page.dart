import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/ui/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> verificaSesion());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context).add(ThemeToggle());
            }, 
            icon: const Icon(Icons.light_mode)
          ),
          IconButton(
            onPressed: (){
              logout();
            }, 
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: const Text('Home'),
    );
  }

  Future<void> verificaSesion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if(userString != null){
      try {
        final Map<String, dynamic> userMap = jsonDecode(userString);
        user = User.fromJson(userMap);
        setState(() {});
      } catch (e) {
        print('Error al decodificar el usuario: $e');
        context.go('/Login');
      }
    } else {
      context.go('/Login');
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    context.go('/Login');
  }
}