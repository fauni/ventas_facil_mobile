import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/buscar_items_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

// ignore: must_be_immutable
class SocioNegocioPage extends StatefulWidget {
  SocioNegocio clienteSeleccionado;
  SocioNegocioPage({super.key, required this.clienteSeleccionado});

  @override
  State<SocioNegocioPage> createState() => _SocioNegocioPageState();
}

class _SocioNegocioPageState extends State<SocioNegocioPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController controllerSearch = TextEditingController();
  int lastItemIndex = 0;
  List<SocioNegocio> clientes = [];
  List<SocioNegocio> clientesNuevos = [];

  @override
  void initState() {
    super.initState();
    cargarSocioDeNegocio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenerControllerScroll();
      controllerSearch.text = '';
    });
  }

  void listenerControllerScroll(){
    _scrollController.addListener(() {
      if(_scrollController.position.atEdge && _scrollController.position.pixels != 0){
        cargarSocioDeNegocio();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void cargarSocioDeNegocio(){
    final currentState = context.read<SocioNegocioBloc>().state;
    if(currentState is SocioNegocioLoaded){
      lastItemIndex = currentState.clientes.length;
    }

    BlocProvider.of<SocioNegocioBloc>(context).add(
      LoadSociosNegocio(
        top: 10, 
        skip: clientes.length,
        text: controllerSearch.text
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Socios de Negocio',),
      body: Column(
        children: [
          BuscadorItemsWidget(controllerSearch: controllerSearch, onSearch: cargarSocioDeNegocio),
          Expanded(
            child: BlocConsumer<SocioNegocioBloc, SocioNegocioState>(
              listener: (context, state) {
                if(state is SocioNegocioNotLoaded){
                  if (state.error.contains('UnauthorizedException')) {
                    LoginDialogWidget.mostrarDialogLogin(context);
                  }
                } else if(state is SocioNegocioLoaded) {
                  // if(clientes.isNotEmpty){
                  //   WidgetsBinding.instance.addPostFrameCallback((_) { 
                  //     if (_scrollController.hasClients) {
                  //       int scrollIndex = max(0, clientes.length - 10);
                  //       double position = scrollIndex * 60; // Asumiendo una altura aproximada por elemento
                  //       _scrollController.animateTo(
                  //         position,
                  //         duration: const Duration(milliseconds: 300),
                  //         curve: Curves.easeOut,
                  //       );
                  //     }
                  //   });
                  // }
                  clientesNuevos = state.clientes;
                  clientes = clientesNuevos; 
                  // clientes = clientes..addAll(clientesNuevos); 
                }
              },
              builder: (context, state) {
                if(state is SocioNegocioLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(state is SocioNegocioLoaded){
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      SocioNegocio cliente = clientes[index];
                      bool isSelected = widget.clienteSeleccionado.codigoSn == cliente.codigoSn;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(context).colorScheme.surface,
                          // backgroundColor: isSelected ? Colors.green : Colors.yellowAccent,
                          child: isSelected 
                            ? const Icon(Icons.check) 
                            : const Icon(Icons.info_outline),
                        ),
                        selected: isSelected,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cliente.id!),
                            Text(cliente.nombreSn!)
                          ],
                        ),
                        subtitle: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('NIT:', style: TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(width: 5,),
                                Text(cliente.nit!),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Razon Social:', style: TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(cliente.cardFName!,)
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        onTap: () {
                          widget.clienteSeleccionado = cliente;
                          isSelected = true;
                          setState(() {});
                          GoRouter.of(context).pop(cliente);
                        },
                        trailing: const Icon(Icons.touch_app),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: clientes.length,
                  );
                } else {
                  return NotFoundInformationWidget(
                    textoBoton: 'Volver a cargar',
                    mensaje: 'Ocurrio un error al traer los socios de negocio.', 
                    onPush: () => cargarSocioDeNegocio(),
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
  
  void esperarTiempo() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}