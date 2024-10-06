
import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

abstract class PedidoPendienteState extends Equatable {
  @override
  List<Object> get props => [];
}

class PedidosPendientesInicial extends PedidoPendienteState{}

// Estados para Cargar Pedidos
class PedidosPendientesLoading extends PedidoPendienteState{}

class PedidosPendientesLoaded extends PedidoPendienteState{
  final List<PedidoList> pedidos;

  PedidosPendientesLoaded(this.pedidos);

  @override
  List<Object> get props => [pedidos];
}

class PedidosPendientesNotLoaded extends PedidoPendienteState {
  final String error;

  PedidosPendientesNotLoaded(this.error);
  @override
  List<Object> get props => [error];
}

class PedidosPendientesUnauthorized extends PedidoPendienteState{}
class PedidosPendientesEmpty extends PedidoPendienteState{}

class PedidosPendientesError extends PedidoPendienteState{
  final String error;
  PedidosPendientesError(this.error);
  @override
  List<Object> get props => [error];
}

// Estados para Cargar pedidos por busqueda
class PedidosPendientesLoadedSearch extends PedidoPendienteState{
  final List<PedidoList> pedidos;

  PedidosPendientesLoadedSearch(this.pedidos);
  @override
  List<Object> get props => [pedidos];
}

// Estados para crear documento de pedido aprobado
class CreacionPedidoAprobadoLoading extends PedidoPendienteState{}
class CreacionPedidoAprobadoExitoso extends PedidoPendienteState{
  final bool seCreo;

  CreacionPedidoAprobadoExitoso(this.seCreo);
  @override
  List<Object> get props => [seCreo];
}
 