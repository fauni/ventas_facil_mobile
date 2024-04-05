import 'package:flutter/material.dart';

// Definir un tipo para el callback
typedef OnSelectionChangedCallback = void Function(String seleccion);

class PanelFilterItemCantidadWidget extends StatefulWidget {
  final OnSelectionChangedCallback onSelectionChanged;

  const PanelFilterItemCantidadWidget({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<PanelFilterItemCantidadWidget> createState() => _PanelFilterItemCantidadWidgetState();
}

class _PanelFilterItemCantidadWidgetState extends State<PanelFilterItemCantidadWidget> {
  String seleccionado = "1";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: Theme.of(context).colorScheme.onSecondary
      ),
      child: SegmentedButton<String>(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        segments: const [
          ButtonSegment<String>(
            value: '1',
            label: Text('Mi Almacen'),
            icon: Icon(Icons.warehouse)
          ),
          ButtonSegment<String>(
            value: '2',
            label: Text('Todos'),
            icon: Icon(Icons.align_horizontal_left)
          )
        ],
        selected: <String>{seleccionado},
        onSelectionChanged: (Set<String> newSelection) {
          setState(() {
            seleccionado = newSelection.first;

            // Llamar al callback proporcionado
            widget.onSelectionChanged(seleccionado);
          });
        },
      ),
    );
  }
}