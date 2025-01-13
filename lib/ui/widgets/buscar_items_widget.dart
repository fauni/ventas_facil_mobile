import 'package:flutter/material.dart';
import 'package:ventas_facil/ui/widgets/button_generic_alone_icon_widget.dart';

class BuscadorItemsWidget extends StatelessWidget {
  final TextEditingController controllerSearch;
  final Function onSearch;

  const BuscadorItemsWidget({
    super.key,
    required this.controllerSearch,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.tertiary),
                border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
              ),
              onSubmitted: (value) => onSearch(),
            ),
          ),
          const SizedBox(width: 2),
          ButtonGenericAloneIconWidget(
            icon: Icons.search,
            height: 48,
            onPressed: () => onSearch(),
          )
        ],
      ),
    );
  }
}
