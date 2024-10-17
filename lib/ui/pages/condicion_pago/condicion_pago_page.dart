import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/condicion_pago/condicion_pago.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

class CondicionPagoPage extends StatefulWidget {
  const CondicionPagoPage({ super.key, required this.idCondicionSeleccionado });

  final int idCondicionSeleccionado;

  @override
  State<CondicionPagoPage> createState() => _CondicionPagoPageState();
}

class _CondicionPagoPageState extends State<CondicionPagoPage> {
  @override
  void initState() {
    super.initState();
    cargarCondicionesDePago();
  }

  void cargarCondicionesDePago(){
    BlocProvider.of<CondicionPagoBloc>(context).add(CargarCondicionPago());
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) async {
      //   context.pop(widget.idCondicionSeleccionado);
      // },
      onPopInvokedWithResult: (didPop, result) {
        context.pop(widget.idCondicionSeleccionado);
      },
      child: Scaffold(
        appBar: const AppBarWidget(titulo: 'Condiciones de Pago'),
        body: BlocBuilder<CondicionPagoBloc, CondicionPagoState>(
          builder: (context, state) {
            if (state is CargarCondicionPagoLoading) 
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is CargarCondicionesPagoExitoso)
            {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.listaCondicionPago.length,
                itemBuilder: (context, index) {
                  CondicionDePago condicion = state.listaCondicionPago[index];
                  bool isSelected = widget.idCondicionSeleccionado == condicion.numeroGrupo;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      child: isSelected ? const Icon(Icons.check) : const Icon(Icons.info_outline),
                    ),
                    selected: isSelected,
                    title: Text('${condicion.nombreCondicionPago}'),
                    onTap: () {
                      // newEmpleadoSeleccionado = empleado;
                      context.pop(condicion.numeroGrupo);
                    },
                  );
                },
              );
            } else if(state is ErrorAlCargarCondicionPago){
              return NotFoundInformationWidget(
                mensaje: 'No se pudo cargar las condiciones de pago', 
                onPush: () {
                  cargarCondicionesDePago();
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}