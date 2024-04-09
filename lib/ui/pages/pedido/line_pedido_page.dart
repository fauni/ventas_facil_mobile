import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item_unidad_medida.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_observacion_widget.dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_widget.dart';

class LinePedidoPage extends StatefulWidget {
  final Pedido pedido;
  const LinePedidoPage({super.key, required this.pedido});

  @override
  State<LinePedidoPage> createState() => _LinePedidoPageState();
}

class _LinePedidoPageState extends State<LinePedidoPage> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController controllerDescripcionAdicional = TextEditingController();
  final TextEditingController controllerCantidad = TextEditingController();
  final TextEditingController controllerPrecio = TextEditingController();
  final TextEditingController controllerDescuento = TextEditingController();
  
  ItemUnidadMedida? selectedUnidad;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UnidadMedidaBloc>(context).add(LoadUnidadMedida());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd(){
    // Anima el scroll hasta el final del contenido
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.easeInOut
    );
  }
  void _scrollToStart(){
    // Anima el scroll hasta el final del contenido
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.easeInOut
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.primary,
  //       foregroundColor: Theme.of(context).colorScheme.onPrimary,
  //       title: const Text('Items'),
  //       actions: [
  //         IconButton(onPressed: () => _scrollToStart(), icon: const Icon(Icons.arrow_upward)),
  //         IconButton(onPressed: () => _scrollToEnd(), icon: const Icon(Icons.arrow_downward)),
  //         IconButton(
  //           onPressed: () async {
  //             final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
  //             setState(() {
  //               widget.pedido.linesPedido.add(result!);
  //               controllerDescripcionAdicional.text = result.descripcionAdicional!;
  //               controllerCantidad.text = result.cantidad.toString();
  //               controllerPrecio.text = result.precioPorUnidad.toString();
  //               controllerDescuento.text = result.descuento.toString();
  //             });
  //             _scrollToEnd();
  //           }, 
  //           icon: const Icon(Icons.add_circle_outline_rounded)
  //         ),
  //         const SizedBox(width: 10,)
  //       ],
  //     ),
  //     body: Stack(
  //       children: [
  //         SingleChildScrollView(
  //           controller: _scrollController,
  //           padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 150),
  //           child: Column(
  //             children: [
  //               ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: widget.pedido.linesPedido.length,
  //                 itemBuilder: (context, index) {
  //                   ItemPedido articulo = widget.pedido.linesPedido.elementAt(index);
  //                   articulo.codigoUnidadMedida == -1 || articulo.codigoUnidadMedida == null
  //                     ? articulo.unidadDeMedidaManual = -1 
  //                     : articulo.unidadDeMedidaManual = 1;
                    
  //                   return GestureDetector(
  //                     onTap: () {
  //                       _showUpdateItemPedido(context, articulo, index);
  //                     },
  //                     child: Container(
  //                       margin: const EdgeInsets.symmetric(vertical: 3),
  //                       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      
  //                       decoration: BoxDecoration(
  //                         color: Theme.of(context).colorScheme.background,
  //                         borderRadius: BorderRadius.circular(10)
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Expanded(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 articulo.unidadDeMedidaManual == -1 
  //                                 ? const SizedBox()
  //                                 : Row(
  //                                   children: [
  //                                     articulo.codigoUnidadMedida == null 
  //                                     ? IconButton(
  //                                       onPressed: (){}, 
  //                                       icon: const Icon(
  //                                         Icons.error_outline_sharp,
  //                                         color: Colors.red,
  //                                       )
  //                                     )
  //                                     : const SizedBox(),
  //                                     const Expanded(child: SizedBox()),
  //                                   ],
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 ),
  //                                 // Text('Descripción Adicional:', style: Theme.of(context).textTheme.titleMedium,),
  //                                 Text('${articulo.descripcionAdicional}'),
  //                                 const Divider(),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Cantidad:', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.cantidad}', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 ),
  //                                 // Text('${articulo.unidadDeMedidaManual} ${articulo.codigoUnidadMedida} ${articulo.nombreUnidadMedida}'),
                                  
  //                                 articulo.unidadDeMedidaManual != null && articulo.unidadDeMedidaManual == 1
  //                                 ? Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Unidad de Medida:', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.nombreUnidadMedida ?? 'Requerido'}', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 )
  //                                 : const SizedBox(),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Precio por unidad:', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.precioPorUnidad} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Descuento(%):', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.descuento ?? 0} %', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text('Total Linea:', style: Theme.of(context).textTheme.titleMedium,),
  //                                     Text('${articulo.precioConDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           widget.pedido.codigoSap == null ? IconButton(
  //                             onPressed: (){
  //                               setState(() {
  //                                 widget.pedido.linesPedido.removeAt(index);
  //                               });
  //                             }, 
  //                             icon: const Icon(
  //                               Icons.remove_circle,
  //                               size: 30,
  //                               color: Colors.red,// Theme.of(context).colorScheme.onError,
  //                             ),
  //                           ) : const SizedBox()
  //                         ],
  //                       )
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
          
  //         const SizedBox(height: 20,),

  //         Positioned(
  //           bottom: 0,
  //           left: 0,
  //           right: 0,
  //           child: Container(
  //             height: 150,
  //             margin: const EdgeInsets.only(left: 5, right: 5),
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).colorScheme.onSurface,
  //               borderRadius: const BorderRadius.only(
  //                 topLeft: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //               )
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text('Total antes del descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                     Text('${widget.pedido.totalAntesDelDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text('Descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                     Text('${widget.pedido.totalDescuento} ${widget.pedido.moneda}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                   ],
  //                 ),
  //                 // Row(
  //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 //   children: [
  //                 //     Text('Impuesto: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                 //     Text('${widget.pedido.totalImpuesto}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                 //   ],
  //                 // ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                     Text('${widget.pedido.totalDespuesDelDescuento}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 3,),
  //                 ElevatedButton.icon(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Theme.of(context).colorScheme.primary,
  //                     foregroundColor: Theme.of(context).colorScheme.onPrimary,
  //                     minimumSize: const Size(double.infinity, 40),
  //                     shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10))
  //                     )
  //                   ),
  //                   onPressed: (){
  //                     setState(() {
  //                       context.pop(widget.pedido);
  //                     });
  //                   }, 
  //                   icon: const Icon(Icons.arrow_back_ios), 
  //                   label: const Text('Volver')
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     )
  //   );
  // }


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: const Text('Items'),
      actions: [
        IconButton(onPressed: () => _scrollToStart(), icon: const Icon(Icons.arrow_upward)),
        IconButton(onPressed: () => _scrollToEnd(), icon: const Icon(Icons.arrow_downward)),
        IconButton(
          onPressed: () async {
            final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
            setState(() {
              widget.pedido.linesPedido.add(result!);
            });
            _scrollToEnd();
          }, 
          icon: const Icon(Icons.add_circle_outline_rounded)
        ),
        const SizedBox(width: 10,)
      ],
    ),
    body: CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              ItemPedido articulo = widget.pedido.linesPedido.elementAt(index);
              return GestureDetector(
                onTap: () => _showUpdateItemPedido(context, articulo, index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  articulo.unidadDeMedidaManual == -1 
                                  ? const SizedBox()
                                  : Row(
                                    children: [
                                      articulo.codigoUnidadMedida == null 
                                      ? IconButton(
                                        onPressed: (){}, 
                                        icon: const Icon(
                                          Icons.error_outline_sharp,
                                          color: Colors.red,
                                        )
                                      )
                                      : const SizedBox(),
                                      const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${articulo.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  ),
                                  Text('${articulo.descripcionAdicional}'),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cantidad:', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${articulo.cantidad}', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  ),
                                  // Text('${articulo.unidadDeMedidaManual} ${articulo.codigoUnidadMedida} ${articulo.nombreUnidadMedida}'),
                                  
                                  articulo.unidadDeMedidaManual != null && articulo.unidadDeMedidaManual == 1
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Unidad de Medida:', style: Theme.of(context).textTheme.titleMedium,),
                                      Text(articulo.nombreUnidadMedida ?? 'Requerido', style: Theme.of(context).textTheme.bodyMedium,),
                                    ],
                                  )
                                  : const SizedBox(),
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
                            widget.pedido.codigoSap == null ? IconButton(
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
                            ) : const SizedBox()
                          ],
                        )
                    ]
                  ),
                ),
              );
            },
            childCount: widget.pedido.linesPedido.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 150,
            margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                    Text('${widget.pedido.totalDespuesDelDescuento}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                  ],
                ),
                const SizedBox(height: 3,),
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
    ),
  );
}

Future<DateTime?> _seleccionarFecha(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null) {
    return picked;
  }
  return null;
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

        int? selectedEntry;

        return AlertDialog(
          title: Row(
            children: [
              Text('Detalle del Item', style: Theme.of(context).textTheme.titleLarge,),
              IconButton(onPressed: (){
                context.pop();
              }, icon: const Icon(Icons.close))
            ],
          ),
          // padding: const EdgeInsets.all(20),
          content: SizedBox(
            height: 420,
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
                  ),
                  const SizedBox(height: 20,),
                  ItemAddPedidoObservacionWidget(
                    titulo: 'Fecha de Entrega', 
                    valor: item.fechaDeEntrega == null ? '' : formatDate(item.fechaDeEntrega!, [dd, '-', mm , '-', yyyy]),
                    isSeleccionable: true, onPush: () async {
                      item.fechaDeEntrega = await _seleccionarFecha(context);
                      setState((){});
                    },
                  ),
                  const SizedBox(height: 20,),
                  BlocConsumer<UnidadMedidaBloc, UnidadMedidaState>(
                    listener: (context, state) {
                      
                    },
                    builder: (context, state) {
                      if(state is UnidadMedidaLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      } else if (state is UnidadMedidaLoaded){
                        if(item.unidadDeMedidaManual == 1){
                          selectedUnidad = ItemUnidadMedida();
                          selectedUnidad?.absEntry = item.codigoUnidadMedida;
                          selectedUnidad?.code = item.nombreUnidadMedida;
                        }

                        
                        return 
                        widget.pedido.linesPedido[indexLine].unidadDeMedidaManual !=null && widget.pedido.linesPedido[indexLine].unidadDeMedidaManual == 1
                        ? Wrap(
                          children: 
                          state.unidades.map((it){
                            return ChoiceChip(
                              label: Text(it.code!), 
                              selected: selectedEntry == it.absEntry,
                              onSelected: (bool selected) {
                                setState(() {
                                  
                                });
                                selectedEntry = selected ? it.absEntry : null;
                                ItemUnidadMedida? nuevaSeleccion = state.unidades.firstWhere((element) => element.absEntry == selectedEntry);
                                widget.pedido.linesPedido[indexLine].codigoUnidadMedida = nuevaSeleccion.absEntry;
                                widget.pedido.linesPedido[indexLine].nombreUnidadMedida = nuevaSeleccion.code;
                              },
                              selectedColor: Colors.blue,
                            );
                          }).toList(),
                        )
                        : const SizedBox();
                      } else {
                        return const Text('Ocurrio un error ');
                      }
                    },
                  ),
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
                  // widget.pedido.linesPedido[indexLine].codigoUnidadMedida = int.parse(controllerUnidadMedida.text);
                  // widget.pedido.linesPedido[indexLine].nombreUnidadMedida = controllerNombreUnidadMedida.text;
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