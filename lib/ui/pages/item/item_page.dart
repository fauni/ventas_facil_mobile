import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';

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
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Items',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
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
                      return ListTile(
                        title: Text('${item.codigo}'),
                        subtitle: Text('${item.descripcion}'),
                        onTap: () {
                          _showBottomSheetCantidad(context, item);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
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
          title: const Text('Ingrese la Cantidad'),
          // padding: const EdgeInsets.all(20),
          content: Wrap(
            children: [
              TextField(
                controller: controllerCantidad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad'
                ),
              ),
              ElevatedButton(
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

                    context.pop(pedido);
                  }
                }, 
                child: const Text('Agregar'),
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