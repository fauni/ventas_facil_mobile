
import 'package:equatable/equatable.dart';

abstract class PedidoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPedidos extends PedidoEvent{}