import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

abstract class PedidoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PedidosLoading extends PedidoState{}

class PedidosLoaded extends PedidoState{
  final List<PedidoList> pedidos;

  PedidosLoaded(this.pedidos);

  @override
  List<Object> get props => [pedidos];
}

class PedidosNotLoaded extends PedidoState {
  final String error;

  PedidosNotLoaded(this.error);
  @override
  List<Object> get props => [error];
}


class PedidosUnauthorized extends PedidoState{}
class PedidosEmpty extends PedidoState{}
class PedidosError extends PedidoState{}

