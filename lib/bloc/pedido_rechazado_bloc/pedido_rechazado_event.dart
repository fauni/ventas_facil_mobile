import 'package:equatable/equatable.dart';

abstract class PedidoRechazadoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPedidosRechazados extends PedidoRechazadoEvent{
  final String username;
  LoadPedidosRechazados(this.username);
}

class LoadPedidosRechazadosBySearch extends PedidoRechazadoEvent{
  final String search;
  LoadPedidosRechazadosBySearch(this.search);

  @override
  List<Object> get props => [search];
}

class LoadPedidosRechazadosByDate extends PedidoRechazadoEvent{
  final DateTime date;
  LoadPedidosRechazadosByDate(this.date);

  @override
  List<Object> get props => [date];
}