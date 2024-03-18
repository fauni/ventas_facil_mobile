import 'dart:convert';
import 'package:ventas_facil/config/helpers/app_config.dart' as config;
import 'package:date_format/date_format.dart';
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
import 'package:ventas_facil/services/genericos_service.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_observacion_widget..dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_widget.dart';

class NuevoPedidoPage extends StatefulWidget {
  const NuevoPedidoPage({super.key});

  @override
  State<NuevoPedidoPage> createState() => _NuevoPedidoPageState();
}

class _NuevoPedidoPageState extends State<NuevoPedidoPage> {
  bool esNuevo = true;
  User user = User();
  Pedido pedido = Pedido(linesPedido: []);
  EmpleadoVenta empleadoSeleccionado = EmpleadoVenta();
  String ubicacion = '';

  final pedidoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pedido.cliente = SocioNegocio();
    pedido.fechaRegistro = DateTime.now();
    pedido.fechaEntrega = DateTime.now();
    pedido.observacion = 'Creado por app mobile ${DateTime.now().toIso8601String()}';

    

    _obtenerUbicacionActual();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> obtenerUsuarioActual());
  }

  void _obtenerUbicacionActual() async {
    ubicacion = await GenericosService().getLocation();
    pedido.ubicacion = ubicacion;
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
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('Nuevo Pedido'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () {
              pedidoController.text = jsonEncode(pedido);
              setState(() {
                
              });
            }, 
            icon: const Icon(Icons.note_add_outlined)
          ),
          IconButton(
            onPressed: () async {
              final result = await context.push<Pedido>('/Pedidos');
              pedido = result!;  
              pedidoController.text = jsonEncode(pedido);
              esNuevo = false;
              BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(pedido.empleado!));
              setState((){});
            }, 
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: BlocListener<PedidoBloc, PedidoState>(
        listener: (context, state) {
          // ESTADOS DE GUARDAR PEDIDO
          if(state is PedidoGuardando){
            mostrarMensajeDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardando...')));
          } else if(state is PedidoGuardadoExitoso || state is PedidoGuardadoError){
            Navigator.of(context, rootNavigator: true).pop('dialog');
          } else if(state is PedidoGuardadoExitoso){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardado con éxito')));
          } else if(state is PedidoGuardadoError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error, ${state.error}')));
          }
          // ESTADOS PARA MODIFICAR PEDIDO
          if(state is PedidoModificando){
            mostrarMensajeDialog(context);
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardando cambios...')));
          } 
          // else if(state is PedidoModificadoExitoso || state is PedidoModificadoError){
          //   Navigator.of(context, rootNavigator: true).pop('dialog');
          //   // context.pop(true);
          // } 
          else if(state is PedidoModificadoExitoso){
            Navigator.of(context, rootNavigator: true).pop('dialog');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modificado con éxito'), backgroundColor: Colors.green,));
          } else if(state is PedidoModificadoError){
            Navigator.of(context, rootNavigator: true).pop('dialog');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error, ${state.error}'), backgroundColor: Colors.red,));
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  // TextField(
                  //   controller: pedidoController,
                  // ),
                  ItemAddPedidoWidget(
                    titulo: 'Cliente',
                    valor: pedido.idCliente == null 
                    ? 'Requerido'
                    : '${pedido.idCliente!} - ${pedido.nombreCliente!}',
                    isSeleccionable: true,
                    onPush: () async {
                      final result = await context.push<SocioNegocio>('/SocioNegocio', extra: pedido.cliente);
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
                        });
                      }
                    }
                  ),
                  ItemAddPedidoWidget(
                    titulo: 'Persona de Contacto', 
                    valor: pedido.personaContacto == null ? '' : '${pedido.contacto!.nombreCliente}', 
                    isSeleccionable: true, 
                    onPush: () async {
                      final result = await context.push<PersonaContacto>('/PersonaContacto', extra: pedido.cliente);
                      if (result != null) {
                        pedido.personaContacto = result.numeroInterno!;
                        pedido.cliente?.personaContacto = result.nombreCliente;
                        pedido.contacto = result;
                        setState(() {
                          
                        });
                      }
                    },
                  ),
                  ItemAddPedidoWidget(
                    titulo: 'Moneda', 
                    valor: pedido.moneda == null ? '' : '${pedido.moneda}', 
                    isSeleccionable: false, 
                    onPush: (){},
                  ),
                  BlocConsumer<SalesEmployeeBloc, SalesEmployeeState>(
                    builder: (context, state) {
                      if(state is SalesEmployeeLoading){
                        return const Center(child: CircularProgressIndicator());
                      } else if(state is SalesEmployeeByIdLoaded){
                        pedido.empleado = state.empleado;
                        pedido.idEmpleado = state.empleado.codigoEmpleado;
                        return ItemAddPedidoWidget(
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
                        return ItemAddPedidoWidget(titulo: 'Empleado de Venta: ', valor: 'No se pudo traer esta información', isSeleccionable: true, onPush: () {},);
                      } else{
                        return ItemAddPedidoWidget(titulo: 'Empleado de Venta: ', valor: 'Requerido', isSeleccionable: true, onPush: () {},);
                      }
                    }, 
                    listener: (context, state) {
                      if(state is SalesEmployeeByIdLoaded){
                        empleadoSeleccionado = state.empleado;
                      }
                    },
                  ),
                  ItemAddPedidoWidget(
                    titulo: 'Fecha de Entrega', 
                    valor: pedido.fechaEntrega == null ? '' : formatDate(pedido.fechaEntrega!, [dd, '-', mm , '-', yyyy]),
                    isSeleccionable: true, onPush: (){},
                  ),
                  ItemAddPedidoWidget(
                    titulo: 'Fecha de Documento', 
                    valor: pedido.fechaRegistro == null ? '': formatDate(pedido.fechaRegistro!, [dd, '-', mm , '-', yyyy]), 
                    isSeleccionable: true, 
                    onPush: (){},
                  ),
                  ItemAddPedidoWidget(
                    titulo: 'Item', 
                    valor: '${pedido.linesPedido.length} Lineas', 
                    isSeleccionable: true, 
                    onPush: () async {
                      final result = await context.push<Pedido>('/LineaDetallePedido', extra: pedido);
                      if(result != null){
                        setState(() {
                          pedido = result;
                        });
                      }
                    },
                  ),
                  ItemAddPedidoObservacionWidget(titulo: 'Observaciones', valor: '${pedido.observacion}', isSeleccionable: true, onPush: (){},),
                  ItemAddPedidoWidget(titulo: 'Total antes del Descuento', valor: '${pedido.totalAntesDelDescuento}', isSeleccionable: false, onPush: (){},),
                  ItemAddPedidoWidget(titulo: 'Impuesto', valor: '${pedido.totalImpuesto}', isSeleccionable: false, onPush: (){},),
                  // ItemAddPedidoWidget(titulo: 'Total', valor: '${pedido.totalDespuesdelImpuesto}', isSeleccionable: false, onPush: (){},),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
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
                        Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                        Text('${pedido.totalDespuesdelImpuesto}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
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
                        if (esNuevo){
                          BlocProvider.of<PedidoBloc>(context).add(SavePedido(pedido));
                        }
                        else{
                          BlocProvider.of<PedidoBloc>(context).add(UpdatePedido(pedido));
                        }
                        setState(() {});
                      }, 
                      icon: const Icon(Icons.save), 
                      label: esNuevo ? const Text('Guardar Pedido'): const Text('Actualizar Pedido')
                    )
                  ],
                ),
              ),
            )
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