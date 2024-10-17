import 'package:flutter/material.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';

// ignore: must_be_immutable
class ViewDetailLinePedidoWidget extends StatelessWidget {
  ViewDetailLinePedidoWidget({
    super.key,
    required this.pedido,
    required this.onPressed
  });

  final Pedido pedido;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 20,right: 20, top: 0, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items (${pedido.linesPedido.length} Lineas)', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error),),
              IconButton(onPressed: onPressed, icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.error,))
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ItemPedido itemPedido = pedido.linesPedido[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
                      Text('${itemPedido.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  Text('${itemPedido.descripcionAdicional}'),
                  // Divider(color: Theme.of(context).colorScheme.error,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cantidad:', style: Theme.of(context).textTheme.titleMedium,),
                      Text('${itemPedido.cantidad}', style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Precio por unidad:', style: Theme.of(context).textTheme.titleMedium,),
                      Text('${itemPedido.precioPorUnidad} ${pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descuento:', style: Theme.of(context).textTheme.titleMedium,),
                      Text('${itemPedido.descuento} %', style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Linea:', style: Theme.of(context).textTheme.titleMedium,),
                      Text('${itemPedido.precioConDescuento} ${pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),
                  // Text(itemPedido.fechaDeEntrega!.toIso8601String())
                ],
              );
            }, 
            separatorBuilder: (context, index) {
              return Divider(color: Theme.of(context).colorScheme.error);
            }, 
            itemCount: pedido.linesPedido.length
          ),
          Divider(color: Theme.of(context).colorScheme.error,),
        ],
      ),
    );
  }
}