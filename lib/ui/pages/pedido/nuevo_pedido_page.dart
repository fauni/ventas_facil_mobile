import 'package:flutter/material.dart';

class NuevoPedidoPage extends StatelessWidget {
  const NuevoPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pedido')
      ),
      body: Center(
        child: Text('Nuevo Pedido'),
      ),
    );
  }
}