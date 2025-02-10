import 'package:flutter/material.dart';

class NotFoundInformationWidget extends StatelessWidget {
  NotFoundInformationWidget({
    super.key,
    required this.iconoBoton,
    required this.textoBoton,
    required this.mensaje,
    required this.onPush, 
  });

  IconData iconoBoton;
  final String textoBoton;
  final String mensaje;
  final Function() onPush;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(Icons.error_outline, size: 40,),
          ),
          Text(mensaje, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            onPressed: onPush, 
            icon: Icon(iconoBoton), 
            label: Text(textoBoton)
          )
        ],
      ),
    );
  }
}