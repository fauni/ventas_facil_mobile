
import 'package:equatable/equatable.dart';
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