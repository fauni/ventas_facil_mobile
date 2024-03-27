import 'package:date_format/date_format.dart';
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
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: const Text('Detalle del Pedido')
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 95, left: 10, right: 10),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  // padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    Row(
                      children: [
                        Flexible(child: PedidoItemFieldWidget(titulo: 'Codigo Pedido', valor: '${pedido.codigoSap}',)),
                        const SizedBox(width: 10,),
                        Flexible(child: PedidoItemFieldWidget(titulo: 'Codigo Sap', valor: '${pedido.numeroDocumento}',)),
                      ],
                    ),
                    PedidoItemFieldWidget(titulo: 'Cliente', valor: '${pedido.codigoCliente} ${pedido.nombreCliente}',),
                    pedido.contacto!.nombreContacto == null ? const SizedBox() : PedidoItemFieldWidget(titulo: 'Persona de Contacto', valor: '${pedido.contacto!.nombreContacto}',),
                    Row(
                      children: [
                        Flexible(child: PedidoItemFieldWidget(titulo: 'Fecha del Documento', valor: formatDate(pedido.fechaDelDocumento!, [dd, '-', mm, '-', yyyy]),)),
                        const SizedBox(width: 10,),
                        Flexible(child: PedidoItemFieldWidget(titulo: 'Fecha de Entrega', valor: formatDate(pedido.fechaDeEntrega!, [dd, '-', mm, '-', yyyy]),)),
                      ],
                    ),
                    PedidoItemFieldWidget(titulo: 'Empleado de Ventas', valor: '${pedido.empleado!.nombreEmpleado}',),
                    PedidoItemFieldWidget(titulo: 'Comentarios', valor: pedido.comentarios ??  '',),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: pedido.linesOrder!.length,
                        itemBuilder: (context, index) {
                          LinesOrder articulo = pedido.linesOrder![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Items (${pedido.linesOrder!.length} Lineas)', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error),),
                              Text('${articulo.descripcionAdicional}', style: TextStyle(color: Theme.of(context).colorScheme.onError),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Producto:', style: Theme.of(context).textTheme.titleMedium,),
                                  Text('${articulo.codigo}', style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                              
                              // Divider(color: Theme.of(context).colorScheme.error,),
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
                                  Text('${articulo.precioUnitario} ${pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Descuento:', style: Theme.of(context).textTheme.titleMedium,),
                                  Text('${articulo.descuento} %', style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Linea:', style: Theme.of(context).textTheme.titleMedium,),
                                  Text('${articulo.precioConDescuento} ${pedido.moneda}', style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const  Divider();
                        },
                      )
                    )
                  ],
                ),
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
                  // ItemBottomDetalleWidget(titulo: 'TOTAL ANTES DEL DESCUENTO', valor: '${pedido.totalAntesDelDescuento}', moneda: '${pedido.moneda}',),
                  // ItemBottomDetalleWidget(titulo: 'DESCUENTO', valor: '${pedido.totalDescuento }', moneda: '${pedido.moneda}'),
                  // ItemBottomDetalleWidget(titulo: 'TOTAL DEL DOCUMENTO', valor: '${pedido.totalDespuesDelDescuento}', moneda: '${pedido.moneda}')
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