import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/producto/item.dart';

class ItemListItemWidget extends StatelessWidget {
  const ItemListItemWidget({
    super.key,
    required this.index,
    required this.item,
    required this.onTap
  });

  final int index;
  final Item item;
  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    _showBottomSheetStock(context, item);
                  }, 
                  icon: const Icon(Icons.remove_red_eye)
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('Codigo', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),)),
                          Expanded(child: Text('${item.codigo}', style: Theme.of(context).textTheme.bodyMedium,))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('Descripción', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),)),
                          Expanded(child: Text('${item.descripcion}', style: Theme.of(context).textTheme.bodyMedium,))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('Cantidad en Stock', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),)),
                          Expanded(child: Text('${item.cantidadEnStock} ${item.unidadMedidaVenta}', style: Theme.of(context).textTheme.bodyMedium,))
                        ],
                      ),
                    ],
                    
                    // title: Text('${item.codigo}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                    // subtitle: Text('${item.descripcion}'),
                    // trailing: Text('${item.cantidadEnStock}'),
                    // onTap: onTap,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: onTap, 
              icon: const Icon(Icons.check), 
              label: const Text('Seleccionar Item'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 40),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheetStock(BuildContext context, Item item){
    showDialog(
      context: context, 
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Text('Detalle de Stock', style: Theme.of(context).textTheme.titleLarge,),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: (){
                context.pop();
              }, 
              icon: const Icon(Icons.arrow_back_ios), 
              label: const Text('Volver'),)
          ],
          // padding: const EdgeInsets.all(20),
          content: SizedBox(
            height: 200,
            width: 300,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: item.informacionItemLote!.length,
              itemBuilder: (context, index) {
                ItemLote lote = item.informacionItemLote![index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Codigo de Almacen', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                        Text('${lote.almacen}', style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Número de Lote', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                        Text('${lote.numeroLote}', style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('En Stock', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                        Text('${lote.stock}', style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fec. Vencimiento', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onError),),
                        Text(formatDate(lote.fechaVencimiento!, [dd, '-', mm , '-', yyyy]), style: Theme.of(context).textTheme.bodySmall,)
                      ],
                    ),
                  ],
                );
              },
            ),
          )
        );
      },
    ).then((result){
      if(result != null){
        // context.pop(result);
      }
    });
  }
}