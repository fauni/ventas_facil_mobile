import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/item_nuevo_pedido_widget.dart';

class NuevoPedidoPage extends StatefulWidget {
  const NuevoPedidoPage({super.key});

  @override
  State<NuevoPedidoPage> createState() => _NuevoPedidoPageState();
}

class _NuevoPedidoPageState extends State<NuevoPedidoPage> {
  User user = User();
  Pedido pedido = Pedido(linesPedido: []);
  EmpleadoVenta empleadoSeleccionado = EmpleadoVenta();

  @override
  void initState() {
    super.initState();
    pedido.fechaRegistro = DateTime.now();
    pedido.fechaEntrega = DateTime.now();
    pedido.observacion = 'Creado por app mobile ${DateTime.now().toIso8601String()}';

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
    final pedidoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pedido'),
        actions: [
          TextButton.icon(
            onPressed: (){
              setState(() {});
              // Clipboard.setData(ClipboardData(text: jsonEncode(pedido)));
              BlocProvider.of<PedidoBloc>(context).add(SavePedido(pedido));
            }, 
            icon: const Icon(Icons.save), 
            label: const Text('Guardar')
          )
        ],
      ),
      body: BlocListener<PedidoBloc, PedidoState>(
        listener: (context, state) {
          if(state is PedidoGuardando){
            mostrarMensajeDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardando...')));
          } else if(state is PedidoGuardadoExitoso || state is PedidoGuardadoError){
            Navigator.of(context, rootNavigator: true).pop('dialog');
            pedidoController.text = jsonEncode(pedido);
            context.pop(true);
          } else if(state is PedidoGuardadoExitoso){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardado con éxito')));
          } else if(state is PedidoGuardadoError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error, ${state.error}')));
          }
        },
        child: ListView(
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
                  // ignore: use_build_context_synchronously
                  BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(EmpleadoVenta(codigoEmpleado: result.codigoEmpleadoVentas)));
                  setState(() {
                    PersonaContacto contactoSeleccionado = result.contactosEmpleado!.firstWhere(
                      (element) => element.nombreCliente == result.personaContacto,
                      orElse: () => PersonaContacto(),
                    ); 
                    pedido.cliente = result;
                    pedido.idCliente = result.codigoSn;
                    pedido.nombreCliente = result.nombreSn;
                    pedido.moneda = result.monedaSn;
                    pedido.personaContacto = contactoSeleccionado.numeroInterno;
                    pedido.contacto = contactoSeleccionado; 
                    // state.empleado = result;
                  });
                }
              },
            ),
            const Divider(),
            ItemNuevoPedidoWidget(
              titulo: 'Persona de Contacto', 
              valor: pedido.personaContacto == null ? '' : '${pedido.contacto!.nombreCliente}', 
              isSeleccionable: true, 
              onPush: () async {
                final result = await context.push<PersonaContacto>('/PersonaContacto', extra: pedido.cliente);
                if (result != null) {
                  pedido.personaContacto = result.numeroInterno!;
                  pedido.contacto = result;
                  setState(() {
                    
                  });
                }
              },
            ),
            const Divider(),
            ItemNuevoPedidoWidget(
              titulo: 'Moneda', 
              valor: pedido.moneda == null ? '' : '${pedido.moneda}', 
              isSeleccionable: false, 
              onPush: (){},
            ),
            const Divider(),
            BlocConsumer<SalesEmployeeBloc, SalesEmployeeState>(
              builder: (context, state) {
                if(state is SalesEmployeeLoading){
                  return const Center(child: CircularProgressIndicator());
                } else if(state is SalesEmployeeByIdLoaded){
                  pedido.empleado = state.empleado;
                  pedido.idEmpleado = state.empleado.codigoEmpleado;
                  return ItemNuevoPedidoWidget(
                    titulo: 'Empleado de Venta: ', 
                    valor: pedido.empleado!.nombreEmpleado!, 
                    isSeleccionable: true, 
                    onPush: () async {
                      final result = await context.push<EmpleadoVenta>('/EmpleadoVentas', extra: state.empleado);
                      if (result != null){
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(result));
                      }
                    },);
                } else if(state is SalesEmployeeError){
                  return ItemNuevoPedidoWidget(titulo: 'Empleado de Venta: ', valor: 'No se pudo traer esta información', isSeleccionable: true, onPush: () {},);
                } else{
                  return ItemNuevoPedidoWidget(titulo: 'Empleado de Venta: ', valor: 'Requerido', isSeleccionable: true, onPush: () {},);
                }
              }, 
              listener: (context, state) {
                if(state is SalesEmployeeByIdLoaded){
                  empleadoSeleccionado = state.empleado;
                }
              },
            ),
            // const Divider(),
            // CambiarEmpleadoVentaWidget(empleadoSeleccionado: empleadoSeleccionado,),
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
            ItemNuevoPedidoWidget(titulo: 'Observaciones', valor: '${pedido.observacion}', isSeleccionable: true, onPush: (){},),
            const Divider(),
            ItemNuevoPedidoWidget(
              titulo: 'Item', 
              valor: '${pedido.linesPedido.length} Lineas', 
              isSeleccionable: true, 
              onPush: () async {
                final result = await context.push<Pedido>('/LineaDetallePedido', extra: pedido);
                if(result != null){
                  setState(() {
                    pedido = result;
                    // pedido.linesPedido = result.linesPedido;
                  });
                }
              },
            ),
            const Divider(),
            ItemNuevoPedidoWidget(titulo: 'Total antes del Descuento', valor: '${pedido.totalAntesDelDescuento}', isSeleccionable: false, onPush: (){},),
            const Divider(),
            ItemNuevoPedidoWidget(titulo: 'Impuesto', valor: '${pedido.totalImpuesto}', isSeleccionable: false, onPush: (){},),
            const Divider(),
            ItemNuevoPedidoWidget(titulo: 'Total', valor: '${pedido.totalDespuesdelImpuesto}', isSeleccionable: false, onPush: (){},),
            const Divider()
          ],
        ),
      ),
    );
  }

  void mostrarMensajeDialog(BuildContext context){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20,),
                Text('Guardando pedido...'),
              ],
            ),
          ),
        );
      },
    );
  }
}


