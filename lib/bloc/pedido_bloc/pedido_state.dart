import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
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

// Estados para Cargar pedidos por busqueda
class PedidosLoadedSearch extends PedidoState{
  final List<PedidoList> pedidos;

  PedidosLoadedSearch(this.pedidos);
  @override
  List<Object> get props => [pedidos];
}

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

// Estados para modificar un pedido
class PedidoModificando extends PedidoState {}

class PedidoModificadoExitoso extends PedidoState {
  final bool seModifico;

  PedidoModificadoExitoso(this.seModifico);
  @override
  List<Object> get props => [seModifico];
}

class PedidoModificadoError extends PedidoState {
  final String error;
  PedidoModificadoError(this.error);

  @override
  List<Object> get props => [error];
}

// Region: Estados para modificar un pedido
class EstadoLineaPedidoModificando extends PedidoState {}

class EstadoLineaPedidoModificadoExitoso extends PedidoState {
  final bool seModifico;
  final ItemPedido item;

  EstadoLineaPedidoModificadoExitoso(this.seModifico, this.item);
  @override
  List<Object> get props => [seModifico, item];
}

class EstadoLineaModificadoError extends PedidoState {
  final String error;
  EstadoLineaModificadoError(this.error);

  @override
  List<Object> get props => [error];
}