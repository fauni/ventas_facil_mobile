import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

// ignore: must_be_immutable
class SocioNegocioPage extends StatefulWidget {
  // final SocioNegocio socioNegocioSeleccionado;
  SocioNegocio clienteSeleccionado;
  SocioNegocioPage({super.key, required this.clienteSeleccionado});

  @override
  State<SocioNegocioPage> createState() => _SocioNegocioPageState();
}

class _SocioNegocioPageState extends State<SocioNegocioPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SocioNegocioBloc>(context).add(LoadSociosNegocio());
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
          if(state is SocioNegocioUnauthorized){
            context.go('/login');
          } else if(state is SocioNegocioNotLoaded){
            // TODO: sIEMPRE INGRESA POR ESTE METODO AUNQUE SEA OTRO ERROR
            context.go('/login');
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
              itemCount: state.clientes.length,
            );
          } else {
            return const Center(
              child: Text('No se pudo traer los Clientes'),
            );
          }
        }
      ),
    );
  }
}