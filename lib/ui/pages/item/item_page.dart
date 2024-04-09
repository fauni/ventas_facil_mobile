import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/buscar_pedidos_widget.dart';
import 'package:ventas_facil/ui/widgets/item_list_item_widget.dart';
import 'package:ventas_facil/ui/widgets/login_dialog_widget.dart';
import 'package:ventas_facil/ui/widgets/not_found_information_widget.dart';

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
  TextEditingController controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarItems();
    controllerSearch.text = '';
  }

  void cargarItems(){
    BlocProvider.of<ItemBloc>(context).add(LoadItems(
      text: controllerSearch.text
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
      appBar: const AppBarWidget(titulo: 'Items',),
      body: Column(
        children: [
          BuscadorPedidosWidget(controllerSearch: controllerSearch, onSearch: cargarItems),
          // Container(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Buscar Items',
          //       prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.tertiary,),
          //       border: UnderlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0)
          //       ),
          //       filled: true,
          //       fillColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
          //     ),
          //   ),
          // ),
          Expanded(
            child: BlocConsumer<ItemBloc, ItemState>(
              listener: (context, state) {
                if(state is ItemNotLoaded){
                  if(state.error.contains('UnauthorizedException')){
                    LoginDialogWidget.mostrarDialogLogin(context);
                  } 
                }
              },
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
                      return ItemListItemWidget(
                        index: index,
                        item: item,
                        onTap: () {
                          // print(item.grupoUnidadMedida);
                          // print(jsonEncode(item));
                          line = ItemPedido();
                          line.codigo = item.codigo;
                          line.descripcion = item.descripcion;
                          line.descripcionAdicional = item.descripcion;
                          line.cantidad = 1; 
                          line.descuento = 0;
                          // ignore: unrelated_type_equality_checks
                          line.unidadDeMedidaManual = item.grupoUnidadMedida; 

                          ListaPrecio precio = item.listaPrecios!.firstWhere(
                            (element) => element.numero == widget.socioNegocio.numeroListaPrecio, 
                            orElse: () => ListaPrecio()
                          );

                          line.precioPorUnidad = precio.precio;

                          context.pop(line);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                  );
                } else {
                  return NotFoundInformationWidget(
                    mensaje: 'No se pudo cargar los Items, intente nuevamente!', 
                    onPush: () {
                      cargarItems();
                    },
                  );
                }
              }, 
            ),
          ),
        ],
      )
    );
  }

}

