import 'package:flutter/material.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/pedido_item_field_widget.dart';

// ignore: must_be_immutable
class DetallePedidoPage extends StatelessWidget {
  PedidoList pedido;
  DetallePedidoPage({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Detalle del Pedido')
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 95, left: 10, right: 10),
              child: Column(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  PedidoItemFieldWidget(titulo: 'Codigo Pedido', valor: '${pedido.id}',),
                  PedidoItemFieldWidget(titulo: 'Codigo Sap', valor: '${pedido.codigoSap}',),
                  PedidoItemFieldWidget(titulo: 'Codigo del Cliente', valor: '${pedido.codigoCliente}',),
                  PedidoItemFieldWidget(titulo: 'Nombre del Cliente', valor: '${pedido.nombreCliente}',),
                  PedidoItemFieldWidget(titulo: 'Persona de Contacto', valor: '${pedido.contacto!.nombreContacto}',),
                  PedidoItemFieldWidget(titulo: 'Fecha del Documento', valor: '${pedido.fechaDelDocumento}',),
                  PedidoItemFieldWidget(titulo: 'Fecha de Entrega', valor: '${pedido.fechaDeEntrega}',),
                  PedidoItemFieldWidget(titulo: 'Empleado de Ventas', valor: '${pedido.empleado!.nombreEmpleado}',),
                  PedidoItemFieldWidget(titulo: 'Comentarios', valor: pedido.comentarios ??  '',),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)
                )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              width: double.infinity,
              height: 95.0,
              child: Column(
                children: [
                  ItemBottomDetalleWidget(titulo: 'TOTAL ANTES DEL IMPUESTO', valor: '${pedido.totalAntesDelDescuento}', moneda: '${pedido.moneda}',),
                  ItemBottomDetalleWidget(titulo: 'IMPUESTO', valor: '${pedido.impuesto}', moneda: '${pedido.moneda}'),
                  ItemBottomDetalleWidget(titulo: 'TOTAL DEL DOCUMENTO', valor: '${pedido.total}', moneda: '${pedido.moneda}')
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

class ItemBottomDetalleWidget extends StatelessWidget {
  const ItemBottomDetalleWidget({
    super.key,
    required this.titulo,
    required this.valor,
    required this.moneda,
  });

  final String titulo;
  final String valor;
  final String moneda;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
        Text('$valor $moneda', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
      ],
    );
  }
}