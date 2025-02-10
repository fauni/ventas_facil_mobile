import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';
import 'package:ventas_facil/ui/widgets/buscar_pedidos_widget.dart';
import 'package:ventas_facil/ui/widgets/item_list_pedido_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class PedidosRechazadosPage extends StatefulWidget {
  const PedidosRechazadosPage({super.key});

  @override
  State<PedidosRechazadosPage> createState() => _PedidosRechazadosPageState();
}

class _PedidosRechazadosPageState extends State<PedidosRechazadosPage> with TickerProviderStateMixin{
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

  // void cargarPedidos(){
  //   BlocProvider.of<PedidoRechazadoBloc>(context).add(LoadPedidosRechazados('Autorizado'));
  // }

  void cargarPedidosSearch(){
    BlocProvider.of<PedidoRechazadoBloc>(context).add(LoadPedidosRechazadosBySearch(controllerSearch.text,));
  }

  void cargarPedidosPorFecha(DateTime date){
    BlocProvider.of<PedidoRechazadoBloc>(context).add(LoadPedidosRechazadosByDate(date));
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
        title: const Text('Pendientes Rechazados'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){
                cargarPedidosSearch();
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
            onSearchDate: (){
              _selectDate(context);
            },
          ),
          Expanded(
            child: BlocConsumer<PedidoRechazadoBloc, PedidoRechazadoState>(
              listener: (context, state) {
                if(state is PedidosRechazadosUnauthorized){
                  LoginDialogWidget.mostrarDialogLogin(context);
                } 
                else if(state is PedidosRechazadosNotLoaded){
                  if(state.error.contains("UnauthorizedException")){
                    LoginDialogWidget.mostrarDialogLogin(context);
                  } else if (state.error.contains("GenericEmptyException")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No se encontraron pedidos rechazados'), backgroundColor: Colors.blue,)
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ocurrio un problema al obtener los Pedidos rechazados'), backgroundColor: Colors.red,)
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is PedidosRechazadosLoading) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                } else if(state is PedidosRechazadosLoaded){
                  if(state.pedidos.isEmpty){
                    return NotFoundInformationWidget(
                      iconoBoton: Icons.refresh,
                      textoBoton: 'Cargar los últimos',
                      mensaje: 'No se encontraron pedidos rechazados',
                      onPush: () {
                        cargarPedidosSearch();
                      },
                    );
                  }
                  return ListaPedidosWidget(pedidos: state.pedidos);
                } else {
                  return NotFoundInformationWidget(
                    iconoBoton: Icons.refresh,
                    textoBoton: 'Volver a cargar',
                    mensaje: '',
                    onPush: () {
                      cargarPedidosSearch();
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
          child: ItemListPedidoWidget(pedido: pedido, status: 'Rechazado')
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 3,);
      }, 
      itemCount: pedidos.length
    );
  }
}

