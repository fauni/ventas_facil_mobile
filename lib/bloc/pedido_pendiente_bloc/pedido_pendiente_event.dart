import 'package:equatable/equatable.dart';

abstract class PedidoPendienteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPedidosPendientes extends PedidoPendienteEvent{
  final String status;
  LoadPedidosPendientes(this.status);
}

class LoadPedidosPendientesBySearch extends PedidoPendienteEvent{
  final String search;
  final String status;
  LoadPedidosPendientesBySearch(this.search, this.status);

  @override
  List<Object> get props => [search];
}

class CrearDocumentoPedidoAprobado extends PedidoPendienteEvent{
  final int id;
  CrearDocumentoPedidoAprobado(this.id);

  @override
  List<Object> get props => [id];
}