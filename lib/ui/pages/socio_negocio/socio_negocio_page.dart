import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

// ignore: must_be_immutable
class SocioNegocioPage extends StatefulWidget {
  // final SocioNegocio socioNegocioSeleccionado;
  SocioNegocio clienteSeleccionado;
  SocioNegocioPage({super.key, required this.clienteSeleccionado});

  @override
  State<SocioNegocioPage> createState() => _SocioNegocioPageState();
}

class _SocioNegocioPageState extends State<SocioNegocioPage> {
  final ScrollController _scrollController = ScrollController();
  int lastItemIndex = 0;
  List<SocioNegocio> clientes = [];
  List<SocioNegocio> clientesNuevos = [];

  @override
  void initState() {
    super.initState();
    cargarSocioDeNegocio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenerControllerScroll();
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
        skip: clientes.length
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Socios de Negocio',),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     GoRouter.of(context).pop(widget.clienteSeleccionado);
      //   }, 
      //   label: const Text('Seleccionar'),
      //   icon: const Icon(Icons.check),
      // ),
      body: BlocConsumer<SocioNegocioBloc, SocioNegocioState>(
        listener: (context, state) {
          if(state is SocioNegocioNotLoaded){
            if (state.error.contains('UnauthorizedException')) {
              LoginDialogWidget.mostrarDialogLogin(context);
            }
          } else if(state is SocioNegocioLoaded) {
            clientesNuevos = state.clientes;
            clientes = clientes..addAll(clientesNuevos); 
            // if(_scrollController.hasClients) {
            //   final position = _scrollController.position.maxScrollExtent;
            //   _scrollController.animateTo(position, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
            // } else {
            //   final position = _scrollController.position.maxScrollExtent;
            //   _scrollController.animateTo(position, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
            // }
          }
        },
        builder: (context, state) {
          if(state is SocioNegocioLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is SocioNegocioLoaded){
            return ListView.separated(
              controller: _scrollController,
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
                  title: Text(cliente.nombreSn!),
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
            return NotFoundInformationWidget(mensaje: 'Ocurrio un error al traer los socios de negocio.', onPush: () => cargarSocioDeNegocio(),);
          }
        }
      ),
    );
  }
  
  void esperarTiempo() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}