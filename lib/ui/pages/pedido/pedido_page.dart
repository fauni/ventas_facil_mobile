import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_event.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/buscar_pedidos_widget.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> with TickerProviderStateMixin{
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
    BlocProvider.of<PedidoBloc>(context).add(LoadPedidos());
  }

  void cargarPedidosSearch(){
    BlocProvider.of<PedidoBloc>(context).add(LoadPedidosSearch(controllerSearch.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Pedidos'),
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
            onSearch: cargarPedidosSearch,
          ),
          // Container(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: controllerSearch,
          //           decoration: InputDecoration(
          //             hintText: 'Buscar Pedidos',
          //             prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.tertiary,),
          //             border: const UnderlineInputBorder(
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 bottomLeft: Radius.circular(10),
          //               )
          //             ),
          //             filled: true,
          //             fillColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
          //           ),
          //         ),
          //       ),
          //       ButtonGenericAloneIconWidget(
          //         icon: Icons.search,
          //         height: 48,
          //         onPressed: () {
          //           cargarPedidosSearch();
          //         },
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: BlocConsumer<PedidoBloc, PedidoState>(
              listener: (context, state) {
                if(state is PedidosUnauthorized){
                  LoginDialogWidget.mostrarDialogLogin(context);
                } 
                else if(state is PedidosNotLoaded){
                  if(state.error.contains("UnauthorizedException")){
                    LoginDialogWidget.mostrarDialogLogin(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ocurrio un problema al obtener los Pedidos'), backgroundColor: Colors.red,)
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is PedidosLoading) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                } else if (state is PedidosLoaded) {
                  return ListaPedidosWidget(pedidos: state.pedidos,);
                } else if(state is PedidosLoadedSearch){
                  return ListaPedidosWidget(pedidos: state.pedidos);
                }
                else {
                  return NotFoundInformationWidget(
                    mensaje: 'No se encontraron pedidos',
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
          child: ItemListPedidoWidget(pedido: pedido)
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      }, 
      itemCount: pedidos.length
    );
  }
}

