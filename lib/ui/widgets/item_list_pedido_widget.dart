import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/config/helpers/map_generic.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/pages/pedido/detalle_pedido_page.dart';

class ItemListPedidoWidget extends StatelessWidget {
  const ItemListPedidoWidget({
    super.key,
    required this.pedido,
  });

  final PedidoList pedido;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetallePedidoPage(pedido: pedido);
            },
            fullscreenDialog: true
          )
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal:5.0, vertical: 20),
            decoration: BoxDecoration(
              color: pedido.estado == 'bost_Open' ?Theme.of(context).colorScheme.primary : Colors.blueGrey
            ),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${pedido.codigoCliente} - ${pedido.nombreCliente}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                    Text(formatDate(pedido.fechaDelDocumento!, [dd,'-',m,'-',yyyy]))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pedido.linesOrder!.length > 1 
                      ? '${pedido.linesOrder!.length} items'
                      : '${pedido.linesOrder!.length} item'
                    ),
                    Text('${pedido.total} ${pedido.moneda}')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(
            color: Theme.of(context).colorScheme.onError,
            onPressed: (){
              context.pop(MapGeneric.pedidoListToPedido(pedido));
              // context.push('/DetallePedido', extra: pedido);
            }, 
            icon: const Icon(Icons.arrow_forward_ios)
          )
        ],
      ),
    );
  }
}