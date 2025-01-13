// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/services/genericos_service.dart';
import 'package:ventas_facil/services/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  User? user;
  double latitude = 0;
  double longitude = 0;
  @override
  void initState(){
    super.initState();
    _saveCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> verificaSesion());
  }

  void _saveCurrentLocation() async {
    bool gpsEnabled = false;
    try{
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      while(!serviceEnabled){
        // Solicitar habilitar los servicios de ubicación
        gpsEnabled = await Geolocator.openLocationSettings(); 
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      }
     
      // Verificar si el usuario tiene permisos de ubicación
      var status = await Permission.location.status;
      if(!status.isGranted){
        // Solicitar permisos de ubicación
        status = await Permission.location.request();
        if(!status.isGranted){
          // Si los permisos no se otorgan, salir del método
          return;
        }
      } 
      Position position = await LocationService().getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;
      setState(() {});
      await GenericosService().saveLocation(position.latitude, position.longitude) ;

    } catch (e){
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(''),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Text(
              user!=null ? '${user!.nombre![0]}${user!.apellido![0]}': 'FA',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          IconButton(
            onPressed: (){
              logout();
            }, 
            icon: const Icon(Icons.logout, size: 30,),
          ),
        ],
      ),
      // drawer: const DrawerWidget(),
      
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                alignment: Alignment.topRight,
                height: 50,
                child: Image.asset('assets/icons/novanexa.png')
              ),
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
              // const Divider(),
              // _buildMenuItem(Icons.calendar_today, 'Actividades', ''),
              // const Divider(),
              // _buildMenuItem(Icons.group, 'Socios Comerciales', ''),
              // const Divider(),
              // _buildMenuItem(Icons.inventory, 'Inventario', ''),
              // const Divider(),
              // _buildMenuItem(Icons.price_change, 'Listas de Precio', ''),
              const Divider(),
              // _buildMenuItem(Icons.add_box_outlined, 'Crear Pedido', '/NuevoPedido'),
              ListTile(
                leading: Icon(Icons.add_box_outlined, color: Theme.of(context).colorScheme.onError,),
                title: Text(
                  'Crear Pedido',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  context.push('/NuevoPedido', extra: {
                    'pedido': Pedido(linesPedido: []),
                    'esRecuperado': 'SI'
                  } );
                },
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onError,),
              ),
              const Divider(),
              _buildMenuItem(Icons.list, 'Pedidos Creados', '/Pedidos'),
              const Divider(),
              _buildMenuItem(Icons.pending_actions, 'Pedidos Pendientes', '/PedidosPendientes'),
              const Divider(),
              _buildMenuItem(Icons.checklist_rounded, 'Pedidos Autorizados', '/PedidosAutorizados'),
              const Divider(),
              _buildMenuItem(Icons.cancel, 'Pedidos Rechazados', '/PedidosRechazados'),
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
            
            child: Column(
              children: [
                // Text('Ubicación: $latitude, $longitude'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('V.1.0.1'),// user != null ? Text('Usuario: ${user!.nombre} ${user!.apellido}') : const SizedBox(),
                    Image.asset(
                      'assets/icons/tomatefaciltoolbar.jpg',
                      height: 80,
                    ),
                  ],
                ),
              ],
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