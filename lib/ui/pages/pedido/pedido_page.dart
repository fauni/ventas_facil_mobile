import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_bloc.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_event.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';

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
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                final result = await context.push<bool>('/NuevoPedido');
                if(result!) {
                  cargarPedidos();
                }
              }, 
              icon: const Icon(Icons.add, size: 30,)
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar.secondary(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Abiertos',),
              Tab(text: 'Todas',),
            ]
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar Pedidos',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          filled: true,
                          fillColor: Colors.grey[200]
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<PedidoBloc, PedidoState>(
                        listener: (context, state) {
                          if(state is PedidosUnauthorized){
                            context.go('/login');
                          } 
                          else if(state is PedidosNotLoaded){
                            // TODO: Revisar estos metodos
                            context.go('/login');
                          }
                        },
                        builder: (context, state) {
                          if (state is PedidosLoading) {
                            return const Center(
                              child: CircularProgressIndicator()
                            );
                          } else if (state is PedidosLoaded) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                PedidoList pedido = state.pedidos[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ItemListPedidoWidget(pedido: pedido)
                                );
                              }, 
                              separatorBuilder: (context, index) {
                                return const Divider();
                              }, 
                              itemCount: state.pedidos.length
                            );
                          } else {
                            return const Text('Container');
                          }
                        }, 
                      ),
                    ),
                  ],
                ),
                const Text('Segundo'),
              ]
            )
          )
        ],
      )
    );
  }
}