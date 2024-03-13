import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';

class LinePedidoPage extends StatefulWidget {
  final Pedido pedido;
  const LinePedidoPage({super.key, required this.pedido});

  @override
  State<LinePedidoPage> createState() => _LinePedidoPageState();
}

class _LinePedidoPageState extends State<LinePedidoPage> {
  // Pedido pedido = Pedido(linesPedido: []);
  // List<ItemPedido> items = [];
  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          context.pop(widget.pedido);
        }, 
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
                  itemCount: widget.pedido.linesPedido.length,
                  itemBuilder: (context, index) {
                    ItemPedido articulo = widget.pedido.linesPedido.elementAt(index);
                    return ListTile(
                      leading: const Icon(Icons.remove, color: Colors.red,),
                      title: Text('${articulo.codigo}', ),
                      subtitle: Text('${articulo.cantidad}'),
                      trailing:Column(
                        children: [
                          Text('${articulo.precioPorUnidad} ${widget.pedido.moneda}'),
                          Text('${ articulo.total } ${widget.pedido.moneda}')
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
                    final result = await context.push<ItemPedido>('/Items', extra: widget.pedido.cliente);
                    setState(() {
                      widget.pedido.linesPedido.add(result!);
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
                    Text('${widget.pedido.totalAntesDelDescuento} ${widget.pedido.moneda}')
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
                    Text('Impuesto', style: temaTexto.titleMedium,),
                    Text('${widget.pedido.totalImpuesto} ${widget.pedido.moneda}')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: temaTexto.titleMedium,),
                    Text('${widget.pedido.totalDespuesdelImpuesto} ${widget.pedido.moneda}')
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