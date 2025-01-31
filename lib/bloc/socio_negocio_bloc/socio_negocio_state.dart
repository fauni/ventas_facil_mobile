import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';

abstract class SocioNegocioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SocioNegocioLoading extends SocioNegocioState{}
class SocioNegocioUnauthorized extends SocioNegocioState{}
class SocioNegocioLoaded extends SocioNegocioState{
  final List<SocioNegocio> clientes;
  final int newItemsStartIndex;

  SocioNegocioLoaded(this.clientes, {this.newItemsStartIndex = 0});

  @override
  List<Object?> get props => [clientes];
}

class SocioNegocioNotLoaded extends SocioNegocioState {
  final String error;

  SocioNegocioNotLoaded(this.error);
  @override
  List<Object?> get props => [error];
}