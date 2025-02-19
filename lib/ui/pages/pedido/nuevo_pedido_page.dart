import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/services/genericos_service.dart';
import 'package:ventas_facil/ui/pages/pedido/view_pdf_page.dart';
import 'package:ventas_facil/ui/widgets/icon_button_generic_widget.dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_observacion_widget.dart';
import 'package:ventas_facil/ui/widgets/item_add_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/view_detail_line_pedido_widget.dart';

// ignore: must_be_immutable
class NuevoPedidoPage extends StatefulWidget {
  NuevoPedidoPage({super.key, required this.pedido, required this.esRecuperado});

  Pedido pedido;
  String esRecuperado;

  @override
  State<NuevoPedidoPage> createState() => _NuevoPedidoPageState();
}

class _NuevoPedidoPageState extends State<NuevoPedidoPage> {
  bool esNuevo = true;
  User user = User();
  Pedido pedido = Pedido(linesPedido: []);
  EmpleadoVenta empleadoSeleccionado = EmpleadoVenta();

  final pedidoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    iniciarValores();
    setState(() {
      if(widget.esRecuperado == 'SI'){
        esNuevo = true;
      } else {
        esNuevo = false;
      }  
    });
    
  }

  void iniciarValores(){
    print(widget.esRecuperado);
    if(widget.pedido.codigoSap == null){
      esNuevo = true;
      pedido = Pedido(linesPedido: []);
      pedido.cliente = SocioNegocio();
      pedido.fechaRegistro = DateTime.now();
      pedido.fechaEntrega = DateTime.now();
      pedido.estado = 'bost_Open';

      pedido.fechaRegistroApp = DateTime.now();
      pedido.horaRegistroApp = DateTime.now();
      pedido.observacion = 'Creado por app mobile ${formatDate(DateTime.now(), [dd,'-',mm,'-',yyyy])}';
      _obtenerUbicacionActual();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> obtenerUsuarioActual());
    } else {
      esNuevo = false;
      pedido = widget.pedido;
      setState(() {
        BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(pedido.empleado!));  
        BlocProvider.of<CondicionPagoBloc>(context).add(CargarCondicionPagoPorId(pedido.idCondicionDePago!));
      });
    }
    
  }

  void obtenerSeriesPorUsuario(String idUsuario){
    BlocProvider.of<UserSerieBloc>(context).add(GetUserSerieByUser(idUsuario));
  }

  void _obtenerUbicacionActual()async  {
    await GenericosService().getLatitud().then((value) => pedido.latitud = value.toString());
    await GenericosService().getLongitud().then((value) => pedido.longitud = value.toString());
    // final longitud = await GenericosService().getLongitud();
    // pedido.latitud = latitud.toString(); 
    // pedido.longitud = longitud.toString(); 
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
      pedido.usuarioVentaFacil = user.userName;
      // print(user.id);
      obtenerSeriesPorUsuario(user.id!);
    });
  }

  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Estas seguro?'),
          content: const Text(
            '¿Estas seguro que quieres salir de esta pagina, los datos no guardados se perderán?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Volver'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Salir'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) async {
      //   if(didPop){
      //     return;
      //   } 
      //   _showBackDialog();
      // },
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          return;
        } 
        _showBackDialog();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
        appBar: AppBar(
          title: esNuevo ? const Text('Crear Pedido') : const Text('Modificar Pedido'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            BlocConsumer<PedidoBloc, PedidoState>(
              listener: (context, state) {
                if(state is ReporteDescargaCorrecta) {
                  OpenFile.open(state.filePath);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('El reporte se descargo correctamente! ${state.filePath}'), backgroundColor: Colors.green, duration: const Duration(seconds: 3),));
                } else if(state is MostrarReporteDescargaCorrecta){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewPDFPage(
                      pedido: pedido,
                      fetchPDF: state.pdfData,
                    ),
                  ));
                } else if (state is ReporteDescargaFallida){
                  if(state.error == "Instance of 'UnauthorizedException'"){
                    LoginDialogWidget.mostrarDialogLogin(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red, duration: const Duration(seconds: 5),));
                  }
                }
              },
              builder: (context, state) {
                if (state is ReporteDescargaEnProgreso){
                  return CircularProgressIndicator(value: state.progreso,);
                } else {
                  return esNuevo ? const SizedBox() : IconButton(
                    onPressed: () async {
                      if(Platform.isWindows){
                        BlocProvider.of<PedidoBloc>(context).add(DescargarYGuardarReportePedidoVenta(pedido.codigoSap!));
                      } else {
                        BlocProvider.of<PedidoBloc>(context).add(DescargarReportePedidoVenta(pedido.codigoSap!));
                      }
                    }, 
                    icon: const Icon(Icons.print)
                  );
                }
              },
            ),
            // IconButton(
            //   onPressed: () async {
            //     BlocProvider.of<PedidoBloc>(context).add(DescargarReportePedidoVenta(54));
            //   }, 
            //   icon: const Icon(Icons.print)
            // ),
            !esNuevo ? IconButton(
              onPressed: (){
                setState(() {
                  esNuevo = true;
                  pedido.id = null;
                  pedido.codigoSap = null;
                  pedido.fechaRegistroApp = DateTime.now();
                  pedido.horaRegistroApp = DateTime.now();
                });
              }, 
              icon: const Icon(Icons.copy)
            ): const SizedBox(),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.pedido = Pedido(linesPedido: []);
                  iniciarValores();
                });
              }, 
              icon: const Icon(Icons.note_add_outlined)
            ),
            
          ],
        ),
        body: BlocListener<PedidoBloc, PedidoState>(
          listener: (context, state) {
            // ESTADOS DE GUARDAR PEDIDO
            if(state is PedidoGuardando){
              mostrarMensajeDialog(context);
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardando...')));
            } else if(state is PedidoGuardadoExitoso){
              setState(() {
                pedido = Pedido(linesPedido: []);
                iniciarValores();
              });
              // pedido = state.pedido;
              // esNuevo = false;
              // Navigator.of(context, rootNavigator: true).pop('dialog');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('Guardado con éxito pedido #${state.pedido.codigoSap}',), backgroundColor: Colors.green, duration: const Duration(seconds: 4),)
              // );
              Navigator.of(context, rootNavigator: true).pop('dialog');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('El pedido se guardo correctamente, sin embargo para la creación del documento necesita ser autorizado',), backgroundColor: Colors.green, duration: Duration(seconds: 4),)
              );
              // iniciarValores();
            } else if(state is PedidoGuardadoError){
              Navigator.of(context, rootNavigator: true).pop('dialog');
              String errorMessage = state.error.replaceAll('Exception: ', '');
              if (state.error.contains("UnauthorizedException")) {
                LoginDialogWidget.mostrarDialogLogin(context);
                // mostrarDialogLogin(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tu sesión no es válida'), backgroundColor: Colors.red,));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red,));
              }
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error, ${state.error.replaceAll('Exception: ', '')}'), backgroundColor: Colors.red,));
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 150),
                child: Column(
                  children: [
                    // TextField(
                    //   controller: pedidoController,
                    // ),
                    ItemAddPedidoWidget(
                      titulo: 'Codigo del Pedido', 
                      valor: '${pedido.codigoSap ?? 0}', 
                      isSeleccionable: false, 
                      onPush: (){},
                    ),
                    const SizedBox(height: 5,),
                    ItemAddPedidoWidget(
                      titulo: 'Numero del Documento', 
                      valor: '${pedido.numeroDocumento ?? 0}', 
                      isSeleccionable: false, 
                      onPush: (){},
                    ),
                    const SizedBox(height: 5,),
                    BlocConsumer<UserSerieBloc, UserSerieState>(
                      listener: (context, state) {
                        if(state.props.isNotEmpty && state.props[0] == "Exception: Error en la solicitud: Instance of 'UnauthorizedException'"){
                          LoginDialogWidget.mostrarDialogLogin(context);
                        } else if(state is UserSerieLoaded){
                          // print('Se cargo ${state.series.first.idSerie}');
                          pedido.serieNumeracion = state.series.first.nombreSerie;
                          pedido.codigoSerieNumeracion = state.series.first.idSerie;
                        }
                      },
                      builder: (context, state) {
                        if(state is UserSerieLoading){
                          return const CircularProgressIndicator();
                        } else if(state is UserSerieLoaded){
                          return ItemAddPedidoWidget(
                            titulo: 'Serie de Numeración', 
                            valor: pedido.serieNumeracion == null ? 'Requerido': pedido.serieNumeracion!, 
                            isSeleccionable: true, 
                            onPush: () async {
                              final result = await context.push<UserSerie>(
                                '/SerieNumeracionUsuario/${state.series.first.idSerie}', 
                                extra: state.series
                              );
                              if(result != null){
                                setState(() {
                                  pedido.serieNumeracion = result.nombreSerie;
                                  pedido.codigoSerieNumeracion = result.idSerie;
                                });
                              }
                            }
                          );
                        } else {
                          return ItemAddPedidoWidget(
                            titulo: 'Serie de Numeración', 
                            valor: 'Requerido', 
                            isSeleccionable: true, 
                            onPush: (){}
                          );
                        }
                      },
                    ),
                    // ItemAddPedidoWidget(
                    //   titulo: 'Serie de Numeración', 
                    //   valor: pedido.serieNumeracion == null 
                    //     ? 'Requerido' 
                    //     : '${pedido.serieNumeracion}', 
                    //   isSeleccionable: true, 
                    //   onPush: () async {
                    //     final result = await context.push<SerieNumeracion>(
                    //       '/SerieNumeracion', 
                    //       extra: pedido.serieNumeracion ?? ''
                    //     );
                    //     if(result != null){
                    //       pedido.serieNumeracion = result.nombre;
                    //       pedido.codigoSerieNumeracion = result.series;
                    //       setState(() {
                            
                    //       });        
                    //     }
                    //   },
                    // ),
                    const SizedBox(height: 5,),
                    ItemAddPedidoWidget(
                      titulo: 'Estado del Pedido', 
                      valor: getEstado(), 
                      isSeleccionable: false, 
                      onPush: (){},
                    ),
                    ItemAddPedidoObservacionWidget(
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
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<CondicionPagoBloc>(context).add(CargarCondicionPagoPorId(result.codigoCondicionPago!));
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
                            pedido.contacto = contactoSeleccionado.codigoCliente == null ? null: contactoSeleccionado; 
                            pedido.idCondicionDePago = result.codigoCondicionPago;
                            pedido.nombreFactura = result.cardFName;
                            pedido.nitFactura = result.nit;

                            final contieneUsuario = pedido.observacion!.contains(user.userName!) ? true : false;
                            if(!contieneUsuario){
                              pedido.observacion = '${user.userName} : ${pedido.observacion}';
                            }
                          });
                        }
                      }
                    ),
                    BlocBuilder<CondicionPagoBloc, CondicionPagoState>(
                      builder: (context, state) {
                        if(state is CargarCondicionPagoLoading){
                          return const CircularProgressIndicator();
                        } else if (state is CargarCondicionPagoExitoso){
                          pedido.idCondicionDePago = state.condicionPago.numeroGrupo;

                          return ItemAddPedidoWidget(
                            titulo: 'C. de Pago', 
                            valor: pedido.idCondicionDePago == null ? '': '${state.condicionPago.nombreCondicionPago}', 
                            isSeleccionable: true, 
                            onPush: () async {
                              final result = await context.push<int>('/CondicionPago', extra: pedido.idCondicionDePago);
                              // ignore: use_build_context_synchronously
                              BlocProvider.of<CondicionPagoBloc>(context).add(CargarCondicionPagoPorId(result!));
                            },
                          );
                        } else {
                            return ItemAddPedidoWidget(
                            titulo: 'Condición de Pago', 
                            valor: 'Requerido', 
                            isSeleccionable: true, 
                            onPush: () {
                              
                            },
                          );
                        }
                      },
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
                    
                    // ItemAddPedidoWidget(
                    //   titulo: 'Moneda', 
                    //   valor: pedido.moneda == null ? '' : '${pedido.moneda}', 
                    //   isSeleccionable: false, 
                    //   onPush: (){},
                    // ),
                    BlocConsumer<SalesEmployeeBloc, SalesEmployeeState>(
                      builder: (context, state) {
                        if(state is SalesEmployeeLoading){
                          return const Center(child: CircularProgressIndicator());
                        } else if(state is SalesEmployeeByIdLoaded){
                          pedido.empleado = state.empleado;
                          pedido.idEmpleado = state.empleado.codigoEmpleado;
                          return ItemAddPedidoObservacionWidget(
                            titulo: 'Empleado de Venta: ', 
                            valor: pedido.empleado!.nombreEmpleado!, 
                            isSeleccionable: false, 
                            onPush: () async {
                              setState(() {
                                
                              });
                              final result = await context.push<EmpleadoVenta>('/EmpleadoVentas', extra: state.empleado);
                              if (result != null){
                                // ignore: use_build_context_synchronously
                                BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(result));
                              } else {
                                // ignore: use_build_context_synchronously
                                BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployeeById(EmpleadoVenta(codigoEmpleado: pedido.idEmpleado)));
                              }

                            },);
                        } else if(state is SalesEmployeeError){
                          return ItemAddPedidoWidget(
                            titulo: 'Empleado de Venta: ', 
                            valor: 'No se pudo traer esta información', 
                            isSeleccionable: true, 
                            onPush: () {},
                          );
                        } 
                        else{
                          return ItemAddPedidoWidget(
                            titulo: 'Empleado de Venta: ', 
                            valor: 'Requerido', 
                            isSeleccionable: true, 
                            onPush: () {
                              
                            },
                          );
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
                      isSeleccionable: true, onPush: () async {
                        var result = await _seleccionarFecha(context);
                        if(result != null){
                          pedido.fechaEntrega = result;
                        }
                        setState((){});
                      },
                    ),
                    ItemAddPedidoWidget(
                      titulo: 'Fecha de Documento', 
                      valor: pedido.fechaRegistro == null ? '': formatDate(pedido.fechaRegistro!, [dd, '-', mm , '-', yyyy]), 
                      isSeleccionable: false, 
                      onPush: () async {
                        var result = await _seleccionarFecha(context);
                        if(result != null){
                          pedido.fechaRegistro = result;
                        }
                        setState((){});
                      },
                    ),
                    ViewDetailLinePedidoWidget(
                      habilitado: true,// esNuevo ? true : false,
                      pedido: pedido, 
                      onPressed: () async {
                        if(validaSeleccionCliente()){
                          final result = await context.push<Pedido>('/LineaDetallePedido', extra: pedido);
                          if(result != null){
                            setState(() {
                              pedido = result;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Primero tienes que elegir un cliente.'), backgroundColor: Colors.red,)
                          );
                        }
                      },
                    ),
                    ItemAddPedidoObservacionWidget(
                      titulo: 'Observaciones', 
                      valor: '${pedido.observacion}', 
                      isSeleccionable: true, 
                      onPush: (){
                        cambiarObservaciones(context);
                      },
                    ),
                    // ItemAddPedidoWidget(titulo: 'Total antes del Descuento', valor: '${pedido.totalAntesDelDescuento}', isSeleccionable: false, onPush: (){},),
                    // ItemAddPedidoWidget(titulo: 'Impuesto', valor: '${pedido.totalImpuesto}', isSeleccionable: false, onPush: (){},),
                    // ItemAddPedidoWidget(titulo: 'Total', valor: '${pedido.totalDespuesdelImpuesto}', isSeleccionable: false, onPush: (){},),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
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
                          Text('Total antes del Descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                          Text('${pedido.totalAntesDelDescuento} ${pedido.moneda ?? 'BS'}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Descuento: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                          Text('${pedido.totalDescuento} ${pedido.moneda ?? 'BS'}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total: ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),),
                          Text('${pedido.totalDespuesDelDescuento} ${pedido.moneda ?? 'BS'}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),),
                        ],
                      ),
                      pedido.estado == 'bost_Open'
                      ? ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          minimumSize: const Size(double.infinity, 40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        ),
                        onPressed: (){
                          if(pedido.linesPedido.isNotEmpty){
                            if (esNuevo){
                              BlocProvider.of<PedidoBloc>(context).add(SavePedido(pedido));
                            }
                            else{
                              BlocProvider.of<PedidoBloc>(context).add(UpdatePedido(pedido));
                            } 
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Necesita agregar Items al pedido antes de guardar'), backgroundColor: Colors.red,)
                            );
                          }
                          setState(() {});
                        }, 
                        icon: const Icon(Icons.save), 
                        label: esNuevo ? const Text('Guardar Pedido'): const Text('Actualizar Pedido')
                      )
                      : const SizedBox()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      // Formatea la fecha como desees.
      // String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      // Actualiza el controlador del TextField específico con la fecha seleccionada.
      return picked;
    }
    return null;
  }

  bool validaSeleccionCliente(){
    return pedido.idCliente == null ? false : true;
  }
  void cambiarObservaciones(BuildContext context){   
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        final observacionesController = TextEditingController();
        observacionesController.text = pedido.observacion!;
        return AlertDialog(
          title: const Text('Observaciones'),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            maxLines: 2,
            maxLength: 250,
            controller: observacionesController,
          ),
          actions: [
            IconButtonGenericWidget(
              label: 'De acuerdo',
              icon: Icons.save,
              onPressed: () {
                setState(() {
                  pedido.observacion = observacionesController.text;
                  context.pop();
                });
              },
            )
          ],
        );
      },
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