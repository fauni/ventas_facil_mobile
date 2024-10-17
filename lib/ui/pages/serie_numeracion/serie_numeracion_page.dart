import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/serie_numeracion/serie_numeracion.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class SerieNumeracionPage extends StatefulWidget {

  const SerieNumeracionPage({super.key, required this.serieSeleccionada});

  final String serieSeleccionada;


  @override
  State<SerieNumeracionPage> createState() => _SerieNumeracionPageState();
}

class _SerieNumeracionPageState extends State<SerieNumeracionPage> {
  

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SerieNumeracionBloc>(context).add(GetSerieNumeracionByIdDocument(17));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Series de Numeracion'),
      body: BlocConsumer<SerieNumeracionBloc, SerieNumeracionState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          if(state is SerieNumeracionLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SerieNumeracionPorDocumentoLoaded){
            return ListView.separated(
              itemBuilder: (context, index) {
                SerieNumeracion serie = state.series[index];
                bool isSelected = widget.serieSeleccionada == serie.nombre ? true : false;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    child: isSelected ? const Icon(Icons.check) : const Icon(Icons.info_outline),
                  ),
                  selected: isSelected,
                  title: Text(serie.nombre!),
                  subtitle: Text(serie.series.toString()),
                  onTap: (){
                    GoRouter.of(context).pop(serie);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              }, 
              itemCount: state.series.length
            );
          } else {
            return const Text('Error al obtener las series de numeración');
          }
        },
      ),
    );
  }
}