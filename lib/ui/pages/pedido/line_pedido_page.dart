import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class LinePedidoPage extends StatefulWidget {
  final Pedido pedido;
  const LinePedidoPage({super.key, required this.pedido});

  @override
  State<LinePedidoPage> createState() => _LinePedidoPageState();
}

class _LinePedidoPageState extends State<LinePedidoPage> {
  // Pedido pedido = Pedido(linesPedido: []);
  // List<ItemPedido> items = [];
  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: const AppBarWidget(titulo: 'Items',),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.pedido.linesPedido.length,
                  itemBuilder: (context, index) {
                    ItemPedido articulo = widget.pedido.linesPedido.elementAt(index);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
                                    Text('${articulo.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Cantidad:', style: Theme.of(context).textTheme.titleMedium,),
                                    Text('${articulo.cantidad}', style: Theme.of(context).textTheme.bodyMedium,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Precio por unidad:', style: Theme.of(context).textTheme.titleMedium,),
                                    Text('${articulo.precioPorUnidad} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Linea:', style: Theme.of(context).textTheme.titleMedium,),
                                    Text('${articulo.total} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: (){}, 
                            icon: const Icon(
                              Icons.remove_circle,
                              size: 30,
                              color: Colors.red,// Theme.of(context).colorScheme.onError,
                            ),
                          )
                        ],
                      )
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary)
                  ),
                  child: ListTile( 
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    title: const Text('Agregar Items al Pedido'),
                    leading: IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.add, size: 30,)
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () async {
                      final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
                      setState(() {
                        widget.pedido.linesPedido.add(result!);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          
          const SizedBox(height: 20,),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              margin: const EdgeInsets.only(left: 5, right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total antes del descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('${widget.pedido.totalAntesDelDescuento}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('0 %', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Impuesto: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('${widget.pedido.totalImpuesto}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('${widget.pedido.totalDespuesdelImpuesto}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 45),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                    ),
                    onPressed: (){
                      setState(() {
                        context.pop(widget.pedido);
                      });
                    }, 
                    icon: const Icon(Icons.arrow_back_ios), 
                    label: const Text('Volver')
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}