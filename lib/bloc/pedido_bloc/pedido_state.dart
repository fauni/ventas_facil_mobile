import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

abstract class PedidoState extends Equatable {
  @override
  List<Object> get props => [];
}
// Estados para Cargar Pedidos
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

// Estados para guardar un nuevo pedido
class PedidoGuardando extends PedidoState {}

class PedidoGuardadoExitoso extends PedidoState {
  final Pedido pedido;

  PedidoGuardadoExitoso(this.pedido);
  @override
  List<Object> get props => [pedido];
}

class PedidoGuardadoError extends PedidoState {
  final String error;
  PedidoGuardadoError(this.error);

  @override
  List<Object> get props => [error];
}
