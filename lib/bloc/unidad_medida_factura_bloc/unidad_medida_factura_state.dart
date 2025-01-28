import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/producto/tfe.dart';

abstract class UnidadMedidaFacturaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TfeUnidadMedidaLoading extends UnidadMedidaFacturaState{}
class TfeUnidadMedidaUnauthorized extends UnidadMedidaFacturaState{}

class TfeUnidadMedidaLoaded extends UnidadMedidaFacturaState{
  final List<Tfe> unidades;
  TfeUnidadMedidaLoaded(this.unidades);

  @override
  List<Object?> get props => [unidades];
}
class TfeUnidadMedidaNotLoaded extends UnidadMedidaFacturaState {
  final String error;

  TfeUnidadMedidaNotLoaded(this.error);
  @override
  List<Object?> get props => [error];
}

class TfeUnidadMedidaEmpty extends UnidadMedidaFacturaState{}