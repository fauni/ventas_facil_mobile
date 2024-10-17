import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/serie_numeracion/serie_numeracion.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class SerieNumeracionUserPage extends StatefulWidget {

  const SerieNumeracionUserPage({super.key, required this.serieSeleccionada, required this.series});

  final String serieSeleccionada;
  final List<UserSerie> series;


  @override
  State<SerieNumeracionUserPage> createState() => _SerieNumeracionUserPageState();
}

class _SerieNumeracionUserPageState extends State<SerieNumeracionUserPage> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Series de Numeracion'),
      body: ListView.separated(
        itemBuilder: (context, index) {
          UserSerie serie = widget.series[index];
          bool isSelected = widget.serieSeleccionada == serie.nombreSerie ? true : false;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.surface,
              child: isSelected ? const Icon(Icons.check) : const Icon(Icons.info_outline),
            ),
            selected: isSelected,
            title: Text(serie.nombreSerie!),
            subtitle: Text(serie.idSerie.toString()),
            onTap: (){
              GoRouter.of(context).pop(serie);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        }, 
        itemCount: widget.series.length
      )
    );
  }
}