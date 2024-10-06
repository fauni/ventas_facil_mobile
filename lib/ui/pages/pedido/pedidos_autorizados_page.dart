import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/buscar_pedidos_widget.dart';
import 'package:ventas_facil/ui/widgets/dialog_loading_widget.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class PedidosAutorizadosPage extends StatefulWidget {
  const PedidosAutorizadosPage({super.key});

  @override
  State<PedidosAutorizadosPage> createState() => _PedidosAutorizadosPageState();
}

class _PedidosAutorizadosPageState extends State<PedidosAutorizadosPage> with TickerProviderStateMixin{
  TextEditingController controllerSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    cargarPedidos();
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void cargarPedidos(){
    BlocProvider.of<PedidoPendienteBloc>(context).add(LoadPedidosPendientes('Autorizado'));
  }

  void cargarPedidosSearch(){
    BlocProvider.of<PedidoPendienteBloc>(context).add(LoadPedidosPendientesBySearch(controllerSearch.text, 'Autorizado'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Pendientes de Autorización'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){
                if(controllerSearch.text.isEmpty){
                  cargarPedidos();
                } else{
                  cargarPedidosSearch();
                }
              }, 
              icon: const Icon(Icons.refresh)
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BuscadorPedidosWidget(
            controllerSearch: controllerSearch,
            onSearch: controllerSearch.text.length > 0 
              ? cargarPedidosSearch 
              : cargarPedidos
          ),
          Expanded(
            child: BlocConsumer<PedidoPendienteBloc, PedidoPendienteState>(
              listener: (context, state) {
                if(state is PedidosPendientesUnauthorized){
                  LoginDialogWidget.mostrarDialogLogin(context);
                } 
                else if(state is PedidosPendientesNotLoaded){
                  if(state.error.contains("UnauthorizedException")){
                    LoginDialogWidget.mostrarDialogLogin(context);
                  } else if (state.error.contains("GenericEmptyException")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No se encontraron pedidos aprobados'), backgroundColor: Colors.blue,)
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ocurrio un problema al obtener los Pedidos'), backgroundColor: Colors.red,)
                    );
                  }
                } else if(state is CreacionPedidoAprobadoExitoso) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Se creo el documento correctamente!'), backgroundColor: Colors.green, duration: Duration(seconds: 5),)
                  );

                  if(controllerSearch.text.isEmpty){
                    cargarPedidos();
                  } else{
                    cargarPedidosSearch();
                  }
                  // context.pop();
                } else if(state is CreacionPedidoAprobadoLoading){
                  DialogLoadingWidget.mostrarMensajeDialog(context);
                } else if(state is PedidosPendientesError){
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ocurrio un error: ${state.error}'), backgroundColor: Colors.red,)
                  );
                }
              },
              builder: (context, state) {
                if (state is PedidosPendientesLoading) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                } else if (state is PedidosPendientesLoaded) {
                  return ListaPedidosWidget(pedidos: state.pedidos,);
                } else if(state is PedidosPendientesLoadedSearch){
                  return ListaPedidosWidget(pedidos: state.pedidos);
                } else if(state is CreacionPedidoAprobadoLoading){
                  return const SizedBox();
                } else if (state is CreacionPedidoAprobadoExitoso){
                  return const SizedBox();
                }
                else {
                  return NotFoundInformationWidget(
                    mensaje: '',
                    onPush: () {
                      cargarPedidos();
                    },
                  );
                }
              }, 
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListaPedidosWidget extends StatelessWidget {
  ListaPedidosWidget({
    super.key,
    required this.pedidos
  });

  List<PedidoList> pedidos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        PedidoList pedido = pedidos[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10)
          ),
          child: ItemListPedidoWidget(pedido: pedido, status: 'Autorizado')
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      }, 
      itemCount: pedidos.length
    );
  }
}

