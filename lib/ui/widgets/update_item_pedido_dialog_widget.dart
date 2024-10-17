import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/unidad_medida_bloc/unidad_medida_bloc.dart';
import 'package:ventas_facil/bloc/unidad_medida_bloc/unidad_medida_state.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item_unidad_medida.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/ui/widgets/item_field_label_icon_widget.dart';

class UpdateItemPedidoDialog extends StatefulWidget {
  final ItemPedido itemPedido;
  final int indexLine;
  final Pedido pedido;

  const UpdateItemPedidoDialog({
    super.key,
    required this.itemPedido,
    required this.indexLine,
    required this.pedido,
  });

  @override
  State<UpdateItemPedidoDialog> createState() => _UpdateItemPedidoDialogState();
}

class _UpdateItemPedidoDialogState extends State<UpdateItemPedidoDialog> {
  late TextEditingController controllerDescripcionAdicional;
  late TextEditingController controllerCantidad;
  late TextEditingController controllerPrecio;
  late TextEditingController controllerDescuento;

  ItemUnidadMedida? selectedUnidad;
  int? selectedEntry;

  @override
  void initState() {
    super.initState();
    controllerDescripcionAdicional = TextEditingController(text: widget.itemPedido.descripcionAdicional);
    controllerCantidad = TextEditingController(text: widget.itemPedido.cantidad.toString());
    controllerPrecio = TextEditingController(text: widget.itemPedido.precioPorUnidad.toString());
    controllerDescuento = TextEditingController(text: widget.itemPedido.descuento.toString());
  }

  @override
  void dispose() {
    controllerDescripcionAdicional.dispose();
    controllerCantidad.dispose();
    controllerPrecio.dispose();
    controllerDescuento.dispose();
    super.dispose();
  }

  Future<DateTime?> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text('Detalle del Item', style: Theme.of(context).textTheme.titleLarge),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLines: 2,
                maxLength: 150,
                decoration: InputDecoration(
                  label: const Text('Descripción Adicional'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                controller: controllerDescripcionAdicional,
              ),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Cantidad'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                controller: controllerCantidad,
              ),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Precio Unitario'),
                  suffixText: '${widget.pedido.moneda}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                controller: controllerPrecio,
              ),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Descuento'),
                  suffixText: '%',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                controller: controllerDescuento,
              ),
              const SizedBox(height: 10,),
              ItemFieldLabelIconWidget(
                titulo: 'Fecha de Entrega', 
                icono: Icons.date_range,
                valor: widget.itemPedido.fechaDeEntrega == null ? '' : formatDate(widget.itemPedido.fechaDeEntrega!, [dd, '-', mm , '-', yyyy]),
                isSeleccionable: true, onPush: () async {
                  var result = await _seleccionarFecha(context);
                  if(result != null){
                    widget.itemPedido.fechaDeEntrega = result;
                  }
                  setState((){});
                },
              ),
              const SizedBox(height: 10,),
              BlocConsumer<UnidadMedidaBloc, UnidadMedidaState>(
                listener: (context, state) {
                  
                },
                builder: (context, state) {
                  if(state is UnidadMedidaLoading){
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (state is UnidadMedidaLoaded){
                    if(widget.itemPedido.unidadDeMedidaManual == 1){
                      selectedUnidad = ItemUnidadMedida();
                      selectedUnidad?.absEntry = widget.itemPedido.codigoUnidadMedida;
                      selectedUnidad?.code = widget.itemPedido.nombreUnidadMedida;
                    }

                    
                    return 
                    widget.pedido.linesPedido[widget.indexLine].unidadDeMedidaManual !=null && widget.pedido.linesPedido[widget.indexLine].unidadDeMedidaManual == 1
                    ? Wrap(
                      children: 
                      state.unidades.map((it){
                        return ChoiceChip(
                          label: Text(it.code!, style: Theme.of(context).textTheme.labelSmall,), 
                          selected: it.absEntry == widget.itemPedido.codigoUnidadMedida ? true: false, // selectedEntry == it.absEntry,
                          onSelected: (bool selected) {
                            setState(() {
                              
                            });
                            selectedEntry = selected ? it.absEntry : null;
                            ItemUnidadMedida? nuevaSeleccion = state.unidades.firstWhere((element) => element.absEntry == selectedEntry);
                            widget.pedido.linesPedido[widget.indexLine].codigoUnidadMedida = nuevaSeleccion.absEntry;
                            widget.pedido.linesPedido[widget.indexLine].nombreUnidadMedida = nuevaSeleccion.code;
                          },
                          selectedColor: Theme.of(context).colorScheme.error.withOpacity(0.5),
                        );
                      }).toList(),
                    )
                    : const SizedBox();
                  } else {
                    return const Text('Ocurrio un error ');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          onPressed: () {
            // Lógica para guardar los cambios
            widget.itemPedido.descripcionAdicional = controllerDescripcionAdicional.text;
            widget.itemPedido.cantidad = double.parse(controllerCantidad.text);
            widget.itemPedido.precioPorUnidad = double.parse(controllerPrecio.text);
            widget.itemPedido.descuento = double.parse(controllerDescuento.text);
            context.pop(widget.itemPedido);
          },
          icon: const Icon(Icons.save),
          label: const Text('Guardar Cambios'),
        ),
      ],
    );
  }
}
