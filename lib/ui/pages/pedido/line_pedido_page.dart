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
  final TextEditingController controllerDescripcionAdicional = TextEditingController();
  final TextEditingController controllerCantidad = TextEditingController();
  final TextEditingController controllerPrecio = TextEditingController();
  final TextEditingController controllerDescuento = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Items'),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
              setState(() {
                widget.pedido.linesPedido.add(result!);
                controllerDescripcionAdicional.text = result.descripcionAdicional!;
                controllerCantidad.text = result.cantidad.toString();
                controllerPrecio.text = result.precioPorUnidad.toString();
                controllerDescuento.text = result.descuento.toString();
              });
            }, 
            icon: const Icon(Icons.add_circle_outline_rounded)
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 130),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.pedido.linesPedido.length,
                  itemBuilder: (context, index) {
                    ItemPedido articulo = widget.pedido.linesPedido.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        _showUpdateItemPedido(context, articulo, index);
                      },
                      child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${articulo.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  ),
                                  // Text('Descripción Adicional:', style: Theme.of(context).textTheme.titleMedium,),
                                  Text('${articulo.descripcionAdicional}'),
                                  const Divider(),
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
                                      Text('Descuento(%):', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${articulo.descuento ?? 0} %', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Linea:', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${articulo.precioConDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  widget.pedido.linesPedido.removeAt(index);
                                });
                              }, 
                              icon: const Icon(
                                Icons.remove_circle,
                                size: 30,
                                color: Colors.red,// Theme.of(context).colorScheme.onError,
                              ),
                            )
                          ],
                        )
                      ),
                    );
                  },
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.primary,
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(color: Theme.of(context).colorScheme.secondary)
                //   ),
                //   child: ListTile( 
                //     textColor: Theme.of(context).colorScheme.onPrimary,
                //     iconColor: Theme.of(context).colorScheme.onPrimary,
                //     title: const Text('Agregar Items al Pedido'),
                //     leading: IconButton(
                //       onPressed: () {}, 
                //       icon: const Icon(Icons.add, size: 30,)
                //     ),
                //     trailing: const Icon(Icons.arrow_forward_ios_rounded),
                //     onTap: () async {
                //       final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
                //       setState(() {
                //         widget.pedido.linesPedido.add(result!);
                //         controllerDescripcionAdicional.text = result.descripcionAdicional!;
                //         controllerCantidad.text = result.cantidad.toString();
                //         controllerPrecio.text = result.precioPorUnidad.toString();
                //         controllerDescuento.text = result.descuento.toString();
                //       });
                //     },
                //   ),
                // )
              ],
            ),
          ),
          
          const SizedBox(height: 20,),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 130,
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
                      Text('${widget.pedido.totalAntesDelDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('${widget.pedido.totalDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Impuesto: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                  //     Text('${widget.pedido.totalImpuesto}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                      Text('${widget.pedido.totalDespuesDelDescuento}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 40),
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

  void _showUpdateItemPedido(BuildContext context, ItemPedido item, int indexLine){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext bc) { 
        controllerDescripcionAdicional.text = item.descripcionAdicional ?? '';
        controllerCantidad.text = item.cantidad.toString();
        controllerPrecio.text = item.precioPorUnidad.toString();
        controllerDescuento.text = item.descuento.toString();
        return AlertDialog(
          title: Text('Detalle del Item', style: Theme.of(context).textTheme.titleLarge,),
          // padding: const EdgeInsets.all(20),
          content: SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    maxLines: 2,
                    maxLength: 150,
                    decoration: InputDecoration(
                      label: const Text('Descripción Adicional'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    controller: controllerDescripcionAdicional,
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Cantidad'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    controller: controllerCantidad,
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Precio Unitario'),
                      suffixText: '${widget.pedido.moneda}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    controller: controllerPrecio,
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Descuento'),
                      suffixText: '%',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    controller: controllerDescuento,
                  )
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
              onPressed: () {
                setState(() {
                  widget.pedido.linesPedido[indexLine].descripcionAdicional = controllerDescripcionAdicional.text;
                  widget.pedido.linesPedido[indexLine].cantidad = double.parse(controllerCantidad.text);
                  widget.pedido.linesPedido[indexLine].precioPorUnidad = double.parse(controllerPrecio.text);
                  widget.pedido.linesPedido[indexLine].descuento = double.parse(controllerDescuento.text);
                });
                context.pop();
              }, 
              icon: const Icon(Icons.save),
              label: const Text('Guardar Cambios'),
            )
          ],
        );
      },
    ).then((result){
      if(result != null){
        context.pop(result);
      }
    });
  }
}