// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/services/genericos_service.dart';
import 'package:ventas_facil/services/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  User? user;
  @override
  void initState(){
    super.initState();
    _saveCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> verificaSesion());
  }

  void _saveCurrentLocation() async {
    try{
      Position position = await LocationService().getCurrentLocation();
      await GenericosService().saveLocation(position.latitude, position.longitude) ;
    } catch (e){
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(''),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              logout();
            }, 
            icon: const Icon(Icons.logout, size: 30,),
          )
        ],
      ),
      // drawer: const DrawerWidget(),
      
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: HeroMode(
                  enabled: true,
                  child: Hero(
                    tag: 'heroIcono',
                    child: Image.asset('assets/icons/icono-logo.png'),
                  ),
                ),
              ),
              const Divider(),
              // _buildMenuItem(Icons.calendar_today, 'Actividades', ''),
              // const Divider(),
              _buildMenuItem(Icons.group, 'Socios Comerciales', ''),
              const Divider(),
              _buildMenuItem(Icons.inventory, 'Inventario', ''),
              // const Divider(),
              // _buildMenuItem(Icons.price_change, 'Listas de Precio', ''),
              const Divider(),
              _buildMenuItem(Icons.receipt, 'Ordenes de Venta', '/NuevoPedido'),
              // Text('${user!.almacen}')
              // const Divider(),
              // _buildMenuItem(Icons.local_shipping, 'Entrega', ''),
              // const Divider(),
              // _buildMenuItem(Icons.medical_information, 'Visita', '')
            ],
          ),
          Positioned(
            bottom: 0,
            right: 10,
            
            child: Image.asset(
              'assets/icons/tomatefaciltoolbar.jpg',
              height: 80,
            )
          )
        ],
      )
    );    
  }

  Widget _buildMenuItem(IconData icon, String title, String route){
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onError,),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        context.push(route);
      },
      trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onError,),
    );
  }
  
  Future<void> verificaSesion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if(userString != null){
      try {
        final Map<String, dynamic> userMap = jsonDecode(userString);
        user = User.fromJson(userMap);
        // print(jsonEncode(user));
        setState(() {});
      } catch (e) {
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