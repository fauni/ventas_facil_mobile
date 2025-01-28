import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/buscar_pedidos_widget.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class PedidosPendientesPage extends StatefulWidget {
  const PedidosPendientesPage({super.key});

  @override
  State<PedidosPendientesPage> createState() => _PedidosPendientesPageState();
}

class _PedidosPendientesPageState extends State<PedidosPendientesPage> with TickerProviderStateMixin{
  TextEditingController controllerSearch = TextEditingController();
  DateTime? fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    cargarPedidosPorFecha(DateTime.now());
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void cargarPedidos(){
    BlocProvider.of<PedidoPendienteBloc>(context).add(LoadPedidosPendientes('Pendiente'));
  }

  void cargarPedidosSearch(){
    BlocProvider.of<PedidoPendienteBloc>(context).add(LoadPedidosPendientesBySearch(controllerSearch.text, 'Pendiente'));
  }

  void cargarPedidosPorFecha(DateTime date){
    BlocProvider.of<PedidoPendienteBloc>(context).add(LoadPedidosPendientesByDate(date, 'Pendiente'));
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Pedidos Pendientes'),
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
            onSearch: controllerSearch.text.isNotEmpty 
              ? cargarPedidosSearch 
              : cargarPedidos,
            onSearchDate: (){
              _selectDate(context);
            }
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
                      const SnackBar(content: Text('No se encontraron pedidos'), backgroundColor: Colors.blue,)
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ocurrio un problema al obtener los Pedidos'), backgroundColor: Colors.red,)
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is PedidosPendientesLoading) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                } else if (state is PedidosPendientesLoaded) {
                  if(state.pedidos.isEmpty){
                    return NotFoundInformationWidget(
                      textoBoton: 'Volver a cargar',
                      mensaje: 'No se encontraron pedidos',
                      onPush: () {
                        cargarPedidos();
                      },
                    );
                  }
                  return ListaPedidosWidget(pedidos: state.pedidos,);
                } else if(state is PedidosPendientesLoadedSearch){
                  if(state.pedidos.isEmpty){
                    return NotFoundInformationWidget(
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
          child: ItemListPedidoWidget(pedido: pedido, status: 'Pendiente',)
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      }, 
      itemCount: pedidos.length
    );
  }
}

