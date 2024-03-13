import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModuloPage extends StatefulWidget {
  const ModuloPage({super.key});

  @override
  State<ModuloPage> createState() => _ModuloPageState();
}

class _ModuloPageState extends State<ModuloPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas Facil'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildMenuItem(Icons.calendar_today, 'Actividades', ''),
          const Divider(),
          _buildMenuItem(Icons.group, 'Socios Comerciales', ''),
          const Divider(),
          _buildMenuItem(Icons.inventory, 'Inventario', ''),
          const Divider(),
          _buildMenuItem(Icons.price_change, 'Listas de Precio', ''),
          const Divider(),
          _buildMenuItem(Icons.receipt, 'Ordenes de Venta', '/Pedidos'),
          const Divider(),
          _buildMenuItem(Icons.local_shipping, 'Entrega', ''),
          const Divider(),
          _buildMenuItem(Icons.medical_information, 'Visita', '')
        ],
      )
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String route){
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary,),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        context.push(route);
      },
      trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary,),
    );
  }
}