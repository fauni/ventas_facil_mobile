import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemAddPedidoObservacionWidget extends StatelessWidget {
  String titulo;
  String valor;
  bool isSeleccionable;
  Function() onPush;

  
  ItemAddPedidoObservacionWidget({
    super.key,
    required this.titulo, 
    required this.valor, 
    required this.isSeleccionable, 
    required this.onPush
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(1),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(width: 20.0,),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Theme.of(context).colorScheme.onSecondary)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(valor, style: Theme.of(context).textTheme.bodySmall)),
                isSeleccionable ? GestureDetector(
                  onTap: onPush, 
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]
                    ),
                    child: const Icon(Icons.menu, size: 15,),
                  ),
                ) : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
