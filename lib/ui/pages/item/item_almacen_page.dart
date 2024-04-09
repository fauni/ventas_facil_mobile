import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/ui/widgets/field_row_widget.dart';
import 'package:ventas_facil/ui/widgets/panel_filter_item_cantidad_widget.dart';

class ItemAlmacenPage extends StatefulWidget {
  const ItemAlmacenPage({super.key, required this.item});

  final Item item;

  @override
  State<ItemAlmacenPage> createState() => _ItemAlmacenPageState();
}

class _ItemAlmacenPageState extends State<ItemAlmacenPage> {
  User user = User();
  List<ItemAlmacen> almacenes = [];
  // ignore: non_constant_identifier_names
  List<ItemAlmacen> almacenes_filtrados = [];
  @override
  void initState() {
    super.initState();
    almacenes = widget.item.informacionItemAlmacen!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> obtenerUsuarioActual());
  }

  void obtenerUsuarioActual() async {
    user = await getCurrentUser();
    if(user.apiToken!.isEmpty){
      // ignore: use_build_context_synchronously
      context.go('/Login');
    }
    setState(() {
      almacenes_filtrados.add(almacenes.firstWhere(
        (almacen) => almacen.codigoAlmacen == user.almacen
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Cantidades ${user.almacen}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PanelFilterItemCantidadWidget(
              onSelectionChanged: (seleccion) {
                almacenes_filtrados = [];
                if(seleccion == "1"){
                  var almacenFiltrado = almacenes.firstWhere(
                    (almacen) => almacen.codigoAlmacen == user.almacen
                  );
                  almacenes_filtrados.add(almacenFiltrado);
                } else {
                  almacenes_filtrados = almacenes;
                }
                setState(() {});
              },
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ItemAlmacen itemAlmacen = almacenes_filtrados[index];
                return Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      FieldRowWidget(
                        titulo: 'Almacen', 
                        valor: '${itemAlmacen.codigoAlmacen}'
                      ),
                      FieldRowWidget(
                        titulo: 'Cantidad en Stock', 
                        valor: '${itemAlmacen.enStock}'
                      ),
                      FieldRowWidget(
                        titulo: 'Cantidad Solicitada', 
                        valor: '${itemAlmacen.solicitada}'
                      ),
                      FieldRowWidget(
                        titulo: 'Cantidad Comprometida', 
                        valor: '${itemAlmacen.comprometida}'
                      ),
                      FieldRowWidget(
                        titulo: 'Cantidad Disponible', 
                        valor: '${itemAlmacen.disponible}'
                      )
                    ],
                  ),
                );
              }, 
              separatorBuilder: (context, index) {
                return const Divider();
              }, 
              itemCount: almacenes_filtrados.length
            ),
          ],
        ),
      ),
    );
  }
}