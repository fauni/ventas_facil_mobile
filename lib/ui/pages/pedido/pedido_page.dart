import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  DateTime? fechaSeleccionada;
  @override
  void initState() {
    super.initState();
    controllerSearch.addListener(() {
      setState(() {
        
      });
    });
    cargarPedidosPorFecha(DateTime.now());
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

  void cargarPedidosPorFecha(DateTime date){
    BlocProvider.of<PedidoBloc>(context).add(LoadPedidosByDate(date));
  }

  Future<void> _selectDate(BuildContext context) async {
    controllerSearch.text = '';
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100)
    );
    if (picked != null && picked != fechaSeleccionada){
      setState(() {
        fechaSeleccionada = picked;
      });
      cargarPedidosPorFecha(picked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) async {
      //   if(didPop){
      //     return;
      //   } 
      //   context.pop();
      // },
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          return;
        } 
        context.pop();
      },
      child: Scaffold(
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
              onSearch: controllerSearch.text.isEmpty ? cargarPedidos : cargarPedidosSearch,
              onSearchDate:(){
                _selectDate(context);
              },
            ),
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
                    if(state.pedidos.isEmpty){
                      return NotFoundInformationWidget(
                        iconoBoton: Icons.refresh,
                        textoBoton: 'Cargar los últimos pedidos',
                        mensaje: 'No se encontraron pedidos con el criterio de busqueda',
                        onPush: () {
                          cargarPedidos();
                        },
                      );
                    }
                    return ListaPedidosWidget(pedidos: state.pedidos);
                  }
                  else {
                    return NotFoundInformationWidget(
                      iconoBoton: Icons.refresh,
                      textoBoton: 'Volver a cargar',
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10)
          ),
          child: ItemListPedidoWidget(pedido: pedido, status: 'Creado',)
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      }, 
      itemCount: pedidos.length
    );
  }
}

