import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/cambiar_empleado_venta_widget.dart';
import 'package:ventas_facil/ui/widgets/item_nuevo_pedido_widget.dart';

class NuevoPedidoPage extends StatefulWidget {
  const NuevoPedidoPage({super.key});

  @override
  State<NuevoPedidoPage> createState() => _NuevoPedidoPageState();
}

class _NuevoPedidoPageState extends State<NuevoPedidoPage> {
  User user = User();
  Pedido pedido = Pedido();
  EmpleadoVenta empleadoSeleccionado = EmpleadoVenta();
  SocioNegocio socioNegocioSeleccionado = SocioNegocio();

  @override
  void initState() {
    super.initState();
    pedido.fechaRegistro = DateTime.now();
    pedido.fechaEntrega = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> obtenerUsuarioActual());
  }

  void obtenerUsuarioActual() async {
          user = await getCurrentUser();
    if(user.apiToken!.isEmpty){
      // ignore: use_build_context_synchronously
      context.go('/Login');
    }
    setState(() {
      empleadoSeleccionado.codigoEmpleado = user.idEmpleadoSap;
      pedido.idEmpleado = user.idEmpleadoSap;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pedido')
      ),
      body: ListView(
        children: [
          const Divider(),
          ItemNuevoPedidoWidget(
            titulo: 'Socio de Negocio', 
            valor: pedido.idCliente == null 
            ? 'Requerido' 
            : '${pedido.idCliente!} - ${pedido.nombreCliente!}', 
            isSeleccionable: true, 
            onPush: () async {
              final result = await context.push<SocioNegocio>('/SocioNegocio', extra: SocioNegocio());
              if (result != null){
                setState(() {
                  socioNegocioSeleccionado = result;
                  pedido.idCliente = result.codigoSn;
                  pedido.nombreCliente = result.nombreSn;
                  pedido.moneda = result.monedaSn;
                  pedido.personaContacto = result.personaContacto;
                  // state.empleado = result;
                });
              }
            },
          ),
          const Divider(),
          ItemNuevoPedidoWidget(
            titulo: 'Persona de Contacto', 
            valor: pedido.personaContacto == null ? '' : '${pedido.personaContacto}', 
            isSeleccionable: false, 
            onPush: (){},
          ),
          const Divider(),
          ItemNuevoPedidoWidget(
            titulo: 'Moneda', 
            valor: pedido.moneda == null ? '' : '${pedido.moneda}', 
            isSeleccionable: false, 
            onPush: (){},
          ),
          const Divider(),
          CambiarEmpleadoVentaWidget(empleadoSeleccionado: empleadoSeleccionado,),
          const Divider(),
          const SizedBox(height: 10,),
          ItemNuevoPedidoWidget(
            titulo: 'Fecha de Entrega', 
            valor: pedido.fechaEntrega == null ? '' : '${pedido.fechaEntrega}', 
            isSeleccionable: true, 
            onPush: (){},
          ),
          const Divider(),
          ItemNuevoPedidoWidget(
            titulo: 'Fecha de Documento', 
            valor: pedido.fechaRegistro == null ? '': '${pedido.fechaRegistro}', 
            isSeleccionable: true, 
            onPush: (){},
          ),
          const Divider(),
          // ItemNuevoPedidoWidget(titulo: 'Numero de Referencia del Cliente', valor: '', isSeleccionable: true, onPush: (){},),
          // const Divider(),
          ItemNuevoPedidoWidget(titulo: 'Observaciones', valor: '', isSeleccionable: true, onPush: (){},),
          const Divider(),
          ItemNuevoPedidoWidget(
            titulo: 'Item', 
            valor: '0 Lineas', 
            isSeleccionable: true, 
            onPush: (){
              context.push('/LineaDetallePedido', extra: socioNegocioSeleccionado);
            },
          ),
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


