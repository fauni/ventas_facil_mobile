import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final String titulo;
  const AppBarWidget({
    super.key,
    required this.titulo
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.surface,
      title: Text(titulo),
      // actions: [
      //   TextButton.icon(
      //     onPressed: (){
      //       setState(() {});
      //       BlocProvider.of<PedidoBloc>(context).add(SavePedido(pedido));
      //     }, 
      //     icon: const Icon(Icons.save), 
      //     label: const Text('Guardar')
      //   )
      // ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



