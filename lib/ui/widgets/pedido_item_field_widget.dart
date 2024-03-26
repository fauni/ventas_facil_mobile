import 'package:flutter/material.dart';

class PedidoItemFieldWidget extends StatelessWidget {
  const PedidoItemFieldWidget({
    super.key,
    required this.titulo,
    required this.valor,
  });

  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              titulo, 
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onError),
            )
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: Text(valor, style: Theme.of(context).textTheme.bodyMedium,)
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}