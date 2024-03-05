import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';

class LinePedidoPage extends StatefulWidget {
  final SocioNegocio socioNegocio;
  const LinePedidoPage({super.key, required this.socioNegocio});

  @override
  State<LinePedidoPage> createState() => _LinePedidoPageState();
}

class _LinePedidoPageState extends State<LinePedidoPage> {
  Pedido pedido = Pedido();
  // List<ItemPedido> items = [];
  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){}, 
        label: const Text('Guardar y volver'),
        icon: const Icon(Icons.save),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: pedido.linesPedido!.length,
                  itemBuilder: (context, index) {
                    ItemPedido articulo = pedido.linesPedido!.elementAt(index);
                    return ListTile(
                      leading: const Icon(Icons.remove, color: Colors.red,),
                      title: Text('${articulo.codigo}', ),
                      subtitle: Text('${articulo.cantidad}'),
                      trailing:Column(
                        children: [
                          Text('${articulo.precioPorUnidad} ${widget.socioNegocio.monedaSn}'),
                          Text('${ articulo.total } ${widget.socioNegocio.monedaSn}')
                        ],
                      ),
                    );
                  },
                ),
                ListTile( 
                  title: const Text('Elegir Item'),
                  leading: IconButton(onPressed: () {
                  }, icon: const Icon(Icons.add, color: Colors.green,)),
                  onTap: () async {
                    final result = await context.push<ItemPedido>('/Items', extra: widget.socioNegocio);
                    setState(() {
                      pedido.linesPedido!.add(result!);
                    });
                  },
                )
              ],
            ),
          ),
          
          const SizedBox(height: 20,),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Antes del Descuento', style: temaTexto.titleMedium,),
                    const Text('500.00 BS')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Descuento', style: temaTexto.titleMedium,),
                    const Text('0.00')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: temaTexto.titleMedium,),
                    const Text('0.00 BS')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: temaTexto.titleMedium,),
                    const Text('0.00')
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}