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
  TextEditingController controllerSearch = TextEditingController();
  final int _pageSize = 10;
  int _currentPage = 0;

  List<SocioNegocio> clientes = [];

  @override
  void initState() {
    super.initState();
    cargarSocioDeNegocio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerSearch.text = '';
    });
  }

  

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      cargarSocioDeNegocio();
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
      cargarSocioDeNegocio();
    });
  }

  void cargarSocioDeNegocio(){
    BlocProvider.of<SocioNegocioBloc>(context).add(
      LoadSociosNegocio(
        top: _pageSize, 
        skip: _currentPage * _pageSize,
        text: controllerSearch.text
      )
    );
  }

  void buscarSocioDeNegocio(){
    _currentPage = 0;
    cargarSocioDeNegocio();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Socios de Negocio',),
      body: Column(
        children: [
          BuscadorItemsWidget(
            controllerSearch: controllerSearch, 
            onSearch: () {
              buscarSocioDeNegocio();
            },
          ),
          Expanded(
            child: BlocConsumer<SocioNegocioBloc, SocioNegocioState>(
              listener: (context, state) {
                if(state is SocioNegocioNotLoaded){
                  if (state.error.contains('UnauthorizedException')) {
                    LoginDialogWidget.mostrarDialogLogin(context);
                  }
                } else if(state is SocioNegocioLoaded){
                  setState(() {
                    clientes = state.clientes;
                  });
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
                      SocioNegocio cliente = state.clientes[index];
                      bool isSelected = widget.clienteSeleccionado.codigoSn == cliente.codigoSn;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(context).colorScheme.surface,
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
                    itemCount: state.clientes.length,
                  );
                } else {
                  if(_currentPage > 0){
                    return NotFoundInformationWidget(
                      iconoBoton: Icons.arrow_back,
                      textoBoton: 'Volver atras',
                      mensaje: 'Ya no existen mas registros.', 
                      onPush: () => _previousPage(),
                    );
                  } 
                  else {
                    return NotFoundInformationWidget(
                      iconoBoton: Icons.refresh,
                      textoBoton: 'Volver a cargar',
                      mensaje: 'Ocurrio un error al traer los socios de negocio.', 
                      onPush: () => cargarSocioDeNegocio(),
                    );
                  }
                }
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _currentPage == 0 ? null : _previousPage,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: clientes.isEmpty ? null : _nextPage, 
              ),
            ],
          )
        ],
      ),
    );
  }
  
  void esperarTiempo() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}