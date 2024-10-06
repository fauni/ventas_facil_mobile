import 'package:flutter/material.dart';

class DialogLoadingWidget {
  static void mostrarMensajeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Procesando...'),
              ],
            ),
          ),
        );
      },
    );
  }
}
