import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/producto/item_unidad_medida.dart';
import 'package:ventas_facil/models/producto/tfe.dart';
import 'package:ventas_facil/models/producto/unidad_medida.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/ui/widgets/item_field_label_icon_widget.dart';

import '../../../bloc/bloc.dart';

class ActualizarItemPedidoPage extends StatefulWidget {
  final ItemPedido itemPedido;
  final int indexLine;
  final Pedido pedido;

  const ActualizarItemPedidoPage({
    super.key,
    required this.itemPedido,
    required this.indexLine,
    required this.pedido,
  });

  @override
  State<ActualizarItemPedidoPage> createState() => _ActualizarItemPedidoPageState();
}

class _ActualizarItemPedidoPageState extends State<ActualizarItemPedidoPage> {
  late TextEditingController controllerDescripcionAdicional;
  late TextEditingController controllerCantidad;
  late TextEditingController controllerPrecio;
  late TextEditingController controllerDescuento;

  ItemUnidadMedida? selectedUnidad;
  UnidadMedida? selectedUnidadMedida;
  Tfe? tfeSeleccionada;
  int? selectedEntry;
  bool yaFueActualizado = false;
  bool yaFueActualizadoTfe = false;

  @override
  void initState() {
    super.initState();
    yaFueActualizado = false;
    yaFueActualizadoTfe = false;
    controllerDescripcionAdicional = TextEditingController(text: widget.itemPedido.descripcionAdicional);
    controllerCantidad = TextEditingController(text: widget.itemPedido.cantidad.toString());
    controllerPrecio = TextEditingController(text: widget.itemPedido.precioPorUnidad.toString());
    controllerDescuento = TextEditingController(text: widget.itemPedido.descuento.toString());
    cargarTfeUnidades();
    cargarUnidadesDeMedida();
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
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }
  
  void cargarTfeUnidades(){
    // BlocProvider.of<UnidadMedidaFacturaBloc>(context).add(LoadTfeUnidadMedida());
  }

  void cargarUnidadesDeMedida(){
    // BlocProvider.of<UnidadMedidaBloc>(context).add(CargarUnidadesDeMedida(widget.itemPedido.codigo!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Actualizar Datos del Item'),
        actions: [
          IconButton(
            onPressed: (){
              guardarCambios();
            }, 
            icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
                  if(yaFueActualizado == false){
                    selectedUnidadMedida = state.unidades.firstWhere(
                      (unidad) => unidad.uomEntry == widget.itemPedido.codigoUnidadMedida,
                      orElse: () => state.unidades.first,
                    );
                    yaFueActualizado = true;
                  }
                  return widget.itemPedido.codigoUnidadMedida! > 0 ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Multiple Unidad de Medida', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          title: Text(selectedUnidadMedida?.uomCode ?? 'Seleccionar Unidad de Medida'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () => _showUnidadMedidaBottomSheet(context, state.unidades),
                        ),
                      ),
                    ],
                  ) : const SizedBox();
                } else {
                  return const Text('* Este item no tiene unidades de medida manual', style: TextStyle(color: Colors.orange),);
                }
              },
            ),

            const SizedBox(height: 10,),
            BlocBuilder<UnidadMedidaFacturaBloc, UnidadMedidaFacturaState>(
              builder: (context, state) {
                if(state is TfeUnidadMedidaLoading){
                  return const Center(child: CircularProgressIndicator(),);
                } else if(state is TfeUnidadMedidaLoaded){
                  if(yaFueActualizadoTfe == false){
                    tfeSeleccionada = state.unidades.firstWhere(
                      (unidad) => unidad.code == widget.itemPedido.codigoTfeUnidad,
                      orElse: () => state.unidades.first,
                    );
                    yaFueActualizadoTfe = true;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Unidad de Medida para Facturación', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(10)
                      //   ),
                      //   child: ListTile(
                      //     title: Text(tfeSeleccionada?.name ?? 'Seleccionar Unidad de Medida para Facturación'),
                      //     trailing: const Icon(Icons.arrow_drop_down),
                      //     onTap: () => _showUnidadMedidaFacturacion(context, state.unidades),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          title: Text('${widget.itemPedido.nombreTfeUnidad}'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () => _showUnidadMedidaFacturacion(context, state.unidades),
                        ),
                      ),
                    ],
                  );
                }
                return Text('* No se pudo cargar las unidades de medida para facturación.', style: TextStyle(color: Colors.orange),);
              },
            ),
            const SizedBox(height: 10,),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
              onPressed: (){
                guardarCambios();
              }, 
              icon: const Icon(Icons.save), 
              label: const Text('Guardar Cambios')
            )
          ],
        ),
      )
    );
  }

  void guardarCambios(){
    // Lógica para guardar los cambios
    widget.itemPedido.descripcionAdicional = controllerDescripcionAdicional.text;
    widget.itemPedido.cantidad = double.parse(controllerCantidad.text);
    widget.itemPedido.precioPorUnidad = double.parse(controllerPrecio.text);
    widget.itemPedido.descuento = double.parse(controllerDescuento.text);
    widget.itemPedido.codigoUnidadMedida = selectedUnidadMedida?.uomEntry;
    widget.itemPedido.nombreUnidadMedida = selectedUnidadMedida?.uomCode;


    if(tfeSeleccionada != null){
      widget.itemPedido.codigoTfeUnidad = tfeSeleccionada!.code;
      widget.itemPedido.nombreTfeUnidad = tfeSeleccionada!.name;
    }
    
    context.pop(widget.itemPedido);
  }
  void _showUnidadMedidaFacturacion(BuildContext context, List<Tfe> unidades){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text('Seleccione la Unidad de Medida para Facturación'),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: unidades.length,
                  itemBuilder: (context, index){
                    Tfe unidad = unidades[index];
                    return ListTile(
                      title: Text(unidad.name!),
                      onTap: (){
                        tfeSeleccionada = unidad;
                        widget.itemPedido.codigoTfeUnidad = unidad.code;
                        widget.itemPedido.nombreTfeUnidad = unidad.name;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }

  void _showUnidadMedidaBottomSheet(BuildContext context, List<UnidadMedida> unidades){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text('Seleccione la Unidad de Medida'),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: unidades.length,
                  itemBuilder: (context, index){
                    UnidadMedida unidad = unidades[index];
                    return ListTile(
                      title: Text('${unidad.uomCode}'),
                      onTap: (){
                        selectedUnidadMedida = unidad;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
