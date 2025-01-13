import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';
import 'package:ventas_facil/ui/widgets/buscar_items_widget.dart';
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
          BuscadorItemsWidget(controllerSearch: controllerSearch, onSearch: cargarItems),
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
                        onTap: () async {
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

                          line.precioPorUnidad = precio.precio ?? 0;
                          // Obtenemos datos del usuario de shared preferences
                          final usuario = await getCurrentUser();
                          line.codigoAlmacen = usuario.almacen;
                          line.codigoProveedor = item.codigoProveedor;
                          line.nombreProveedor = item.proveedorPrincipal!.nombreSn;
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

