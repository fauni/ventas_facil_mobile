import 'package:flutter/material.dart';

class ItemNuevoPedidoWidget extends StatelessWidget {
  String titulo;
  String valor;
  bool isSeleccionable;
  Function onPush;
  ItemNuevoPedidoWidget({super.key, required this.titulo, required this.valor, required this.isSeleccionable, required this.onPush});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPush(),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text('$titulo: ', style: const TextStyle(color: Colors.blue),), // Theme.of(context).colorScheme.secondary),),
            Expanded(child: Text(valor)),
            isSeleccionable 
            ? Icon(
              Icons.arrow_forward_ios, 
              color: Theme.of(context).colorScheme.secondary,
            )
            : const SizedBox()
          ],
        ),
      ),
    );
  }
}