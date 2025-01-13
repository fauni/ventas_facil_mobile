import 'package:flutter/material.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';

// ignore: must_be_immutable
class ViewDetailLinePedidoWidget extends StatelessWidget {
  ViewDetailLinePedidoWidget({
    super.key,
    this.habilitado = true,
    required this.pedido,
    required this.onPressed
  });

  final bool habilitado;
  final Pedido pedido;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items (${pedido.linesPedido.length} Lineas)', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error),),
                  habilitado == true ? IconButton(
                    onPressed: onPressed, 
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.error,)
                  ) : const SizedBox()
                ],
              ),
              SizedBox(
                height: pedido.linesPedido.isNotEmpty ? 300 :0,
                child: ListView.separated(
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
              ),
              const SizedBox(height: 15,),
              // Divider(color: Theme.of(context).colorScheme.error,),
            ],
          ),
        ),
        // Posicionamos abajo y al centro el botón de agregar
        pedido.linesPedido.length > 2 ? Positioned(
          bottom: 5,
          left: 30,
          child: Row(
            children: [
              Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary,),
              Text('Deslice para ver mas ítems', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), fontSize: 13),),
            ],
          )
        ) : const SizedBox()
      ],
    );
  }
}