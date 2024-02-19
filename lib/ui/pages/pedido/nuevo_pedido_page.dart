import 'package:flutter/material.dart';
import 'package:ventas_facil/ui/widgets/item_nuevo_pedido_widget.dart';

import '../../widgets/item_nuevo_pedido_widget.dart';

class NuevoPedidoPage extends StatelessWidget {
  const NuevoPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pedido')
      ),
      body: ListView(
        children: [
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Socio de Negocio', valor: 'Requerido', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Persona de Contacto', valor: '', isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Moneda', valor: 'Requerido', isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Fecha de Entrega', valor: DateTime.now().toIso8601String(), isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Fecha de Documento', valor: DateTime.now().toIso8601String(), isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Moneda', valor: 'Requerido', isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Empleado de Venta', valor: '', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Numero de Referencia del Cliente', valor: '', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Observaciones', valor: '', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Item', valor: '0 Lineas', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Total antes del Descuento', valor: '0', isSeleccionable: false, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Porcentaje del Descuento', valor: '', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Total', valor: '', isSeleccionable: false, onPush: (){},),
          const Divider()
        ],
      ),
    );
  }
}