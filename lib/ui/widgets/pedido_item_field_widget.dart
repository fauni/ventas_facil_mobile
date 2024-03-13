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
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              titulo, 
              style: Theme.of(context).textTheme.titleSmall,
            )
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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