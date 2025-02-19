import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/producto/unidad_medida.dart';

abstract class UnidadMedidaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnidadMedidaLoading extends UnidadMedidaState{}
class UnidadMedidaUnauthorized extends UnidadMedidaState{}
class UnidadMedidaLoaded extends UnidadMedidaState{
  final List<UnidadMedida> unidades;
  UnidadMedidaLoaded(this.unidades);

  @override
  List<Object?> get props => [unidades];
}

class UnidadMedidaNotLoaded extends UnidadMedidaState {
  final String error;

  UnidadMedidaNotLoaded(this.error);
  @override
  List<Object?> get props => [error];
}

class UnidadMedidaEmpty extends UnidadMedidaState{}