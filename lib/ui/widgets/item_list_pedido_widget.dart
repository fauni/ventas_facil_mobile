import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/config/helpers/map_generic.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/pages/pedido/detalle_pedido_page.dart';
import 'package:ventas_facil/ui/widgets/button_generic_widget.dart';


class ItemListPedidoWidget extends StatelessWidget {
  const ItemListPedidoWidget({
    super.key,
    required this.pedido,
    required this.status
  });

  final PedidoList pedido;
  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PedidoPendienteBloc, PedidoPendienteState>(
      listener: (context, state) {
        
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: getEstado() == 'Abierto' 
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onTertiary,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DetallePedidoPage(pedido: pedido);
                    },
                    fullscreenDialog: true
                  )
                );
              }, 
              icon: const Icon(Icons.remove_red_eye_sharp)
            ),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Codigo SAP: ', style: Theme.of(context).textTheme.titleSmall,),
                    Text('${pedido.numeroDocumento}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Número de Documento: ', style: Theme.of(context).textTheme.titleSmall,),
                    Text('${pedido.codigoSap}'),
                  ],
                ),
                Text('${pedido.codigoCliente} ${pedido.nombreCliente}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fecha del Documento: ', style: Theme.of(context).textTheme.titleSmall,),
                    Text(formatDate(pedido.fechaDelDocumento!, [dd,'-',m,'-',yyyy]))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL: ', style: Theme.of(context).textTheme.titleSmall,),
                    Text('${pedido.total} ${pedido.moneda}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estado del Documento: ', style: Theme.of(context).textTheme.titleSmall,),
                    Text(getEstado())
                  ],
                ),
                status == 'Autorizado' ? const Divider() : const SizedBox(),
                status == 'Autorizado'
                ? ButtonGenericWidget(
                  icon: Icons.check,
                  label: 'Crear Pedido', 
                  height: 40, 
                  width: double.infinity,
                  onPressed: (){
                    // DialogLoadingWidget.mostrarMensajeDialog(context);
                    // Timer(const Duration(seconds: 5), () { 
                    //   context.pop();
                    // });
                    BlocProvider.of<PedidoPendienteBloc>(context).add(CrearDocumentoPedidoAprobado(pedido.id!));
                  }
                ): const SizedBox()
              ],
            ),
          ),
          const SizedBox(width: 10,),
          status == 'Creado'
          ? IconButton(
            color: Theme.of(context).colorScheme.onError,
            onPressed: (){
              // context.pop(MapGeneric.pedidoListToPedido(pedido));
              context.push('/NuevoPedido', extra: MapGeneric.pedidoListToPedido(pedido));
            }, 
            icon: const Icon(Icons.arrow_forward_ios)
          )
          : const SizedBox()
        ],
      ),
    );
  }

  String getEstado(){
    String estadoGeneral = '';
    if(pedido.estado == 'bost_Close' && pedido.estadoCancelado == 'csYes'){
      estadoGeneral = 'Cancelado';
    } else if (pedido.estadoCancelado == 'csNo' && pedido.estado == 'bost_Close'){
      estadoGeneral = 'Cerrado';
    } else {
      estadoGeneral = 'Abierto';
    }
    return estadoGeneral;
  }
}