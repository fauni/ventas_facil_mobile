import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class ItemPage extends StatefulWidget {
  final SocioNegocio socioNegocio;
  const ItemPage({super.key, required this.socioNegocio});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  ItemPedido line = ItemPedido();
  // Item itemSeleccionado = Item();
  final TextEditingController controllerCantidad = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ItemBloc>(context).add(LoadItems());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: const AppBarWidget(titulo: 'Items',),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Items',
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
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if(state is ItemLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(state is ItemLoaded){
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      Item item = state.items[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text('${item.codigo}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                          subtitle: Text('${item.descripcion}'),
                          onTap: () {
                            _showBottomSheetCantidad(context, item);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No se pudo cargar los Items, intente nuevamente!'),
                  );
                }
              }, 
            ),
          ),
        ],
      )
    );
  }

  void _showBottomSheetCantidad(BuildContext context, Item item){
    showDialog(
      context: context, 
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Text('Ingrese la Cantidad', style: Theme.of(context).textTheme.titleLarge,),
          // padding: const EdgeInsets.all(20),
          content: Wrap(
            children: [
              TextField(
                controller: controllerCantidad,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.add_chart_sharp),
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  )
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: Size(double.infinity, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                onPressed: () {
                  if(controllerCantidad.text.isEmpty){
                    // TODO: Cambiar por un mensaje que se muestre
                  } else {
                    line = ItemPedido();
                    line.codigo = item.codigo;
                    line.descripcion = item.descripcion;
                    line.cantidad = double.tryParse(controllerCantidad.text) ?? 0; 

                    ListaPrecio precio = item.listaPrecios!.firstWhere(
                      (element) => element.numero == widget.socioNegocio.numeroListaPrecio, 
                      orElse: () => ListaPrecio()
                    );

                    line.precioPorUnidad = precio.precio;

                    context.pop(line);
                  }
                }, 
                icon: const Icon(Icons.add),
                label: const Text('Agregar'),
              )
            ],
          ),
        );
      },
    ).then((result){
      if(result != null){
        context.pop(result);
      }
    });
  }
}