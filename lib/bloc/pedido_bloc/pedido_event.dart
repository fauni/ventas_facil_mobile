
import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';

abstract class PedidoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPedidos extends PedidoEvent{}

class LoadPedidosSearch extends PedidoEvent{
  final String search;
  LoadPedidosSearch(this.search);

  @override
  List<Object> get props => [search];
}

class SavePedido extends PedidoEvent {
  final Pedido pedido;
  SavePedido(this.pedido);

  @override
  List<Object> get props => [pedido];
}

class UpdatePedido extends PedidoEvent{
  final Pedido pedido;
  UpdatePedido(this.pedido);
  @override
  List<Object> get props => [pedido]; 
}

class UpdateEstadoLineaPedido extends PedidoEvent{
  final Pedido pedido;
  final ItemPedido item;
  UpdateEstadoLineaPedido(this.pedido, this.item);
  @override
  List<Object> get props => [pedido, item]; 
}

// Region del Reporte
class DescargarYGuardarReportePedidoVenta extends PedidoEvent {
  final int id;
  DescargarYGuardarReportePedidoVenta(this.id);

  @override
  List<Object> get props => [id];  
}

class DescargarReportePedidoVenta extends PedidoEvent {
  final int id;
  DescargarReportePedidoVenta(this.id);

  @override
  List<Object> get props => [id];  
}

