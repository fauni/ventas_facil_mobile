import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_event.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> with TickerProviderStateMixin{

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cargarPedidos();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void cargarPedidos(){
    BlocProvider.of<PedidoBloc>(context).add(LoadPedidos());
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
          IconButton(
            onPressed: (){
              cargarPedidos();
            }, 
            icon: const Icon(Icons.refresh)
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                // final result = await context.push<bool>('/NuevoPedido');
                // if(result!) {
                //   cargarPedidos();
                // }
              }, 
              icon: const Icon(Icons.sort, size: 30,)
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Pedidos',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.tertiary,),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<PedidoBloc, PedidoState>(
              listener: (context, state) {
                if(state is PedidosUnauthorized){
                  LoginDialogWidget.mostrarDialogLogin(context);
                } 
                else if(state is PedidosNotLoaded){
                  if(state.error.contains("UnauthorizedException")){
                    // TODO: Revisar estos metodos
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
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      PedidoList pedido = state.pedidos[index];
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
                    itemCount: state.pedidos.length
                  );
                } else {
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

