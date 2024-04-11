import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemFieldLabelIconWidget extends StatelessWidget {
  String titulo;
  IconData icono;
  String valor;
  bool isSeleccionable;
  Function() onPush;

  
  ItemFieldLabelIconWidget({
    super.key,
    required this.titulo,
    required this.icono, 
    required this.valor, 
    required this.isSeleccionable, 
    required this.onPush
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.labelSmall,),
        const SizedBox(width: 20.0,),
        Container(
          padding: const EdgeInsets.only(right: 10, left: 10),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
                  ),
                  child: Icon(icono, size: 15,),
                ),
              ) : const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
