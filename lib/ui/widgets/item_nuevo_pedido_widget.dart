// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ItemNuevoPedidoWidget extends StatelessWidget {
  String titulo;
  String valor;
  bool isSeleccionable;
  Function() onPush;
  ItemNuevoPedidoWidget({super.key, required this.titulo, required this.valor, required this.isSeleccionable, required this.onPush});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: isSeleccionable ? 10.0 : 30.0,
        left: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('$titulo: ', style: const TextStyle(color: Colors.blue),)),
                Expanded(child: Text(valor, textAlign: TextAlign.right, maxLines: 3,)),
              ],
            ),
          ), // Theme.of(context).colorScheme.secondary),),
          isSeleccionable 
          ? IconButton(
              icon: const Icon(Icons.arrow_forward_ios), 
              color: Theme.of(context).colorScheme.secondary,
              onPressed: onPush,
            )
          : const SizedBox()
        ],
      ),
    );
  }
}