import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

abstract class PedidoRechazadoState extends Equatable{
  @override
  List<Object> get props => [];
}

class PedidosRechazadosInicial extends PedidoRechazadoState {}

class PedidosRechazadosLoading extends PedidoRechazadoState {}

class PedidosRechazadosLoaded extends PedidoRechazadoState {
  final List<PedidoList> pedidos;

  PedidosRechazadosLoaded(this.pedidos);  

  @override
  List<Object> get props => [pedidos];
}

class PedidosRechazadosNotLoaded extends PedidoRechazadoState {
  final String error;
  PedidosRechazadosNotLoaded(this.error);
  @override
  List<Object> get props => [error];
}

class PedidosRechazadosUnauthorized extends PedidoRechazadoState {}
