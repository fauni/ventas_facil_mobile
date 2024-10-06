import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/condicion_pago/condicion_pago.dart';

abstract class CondicionPagoState extends Equatable {
  @override
  List<Object> get props => [];
}

class CondicionPagoInicial extends CondicionPagoState{}
// Estados para Cargar Condicion de PAgo
class CargarCondicionPagoLoading extends CondicionPagoState{}

class CargarCondicionesPagoExitoso extends CondicionPagoState{
  final List<CondicionDePago> listaCondicionPago;
  CargarCondicionesPagoExitoso(this.listaCondicionPago);
  @override
  List<Object> get props => [listaCondicionPago];
}

class CargarCondicionPagoExitoso extends CondicionPagoState{
  final CondicionDePago condicionPago;
  CargarCondicionPagoExitoso(this.condicionPago);
  @override
  List<Object> get props => [condicionPago];
}

class ErrorAlCargarCondicionPago extends CondicionPagoState {
  final String error;
  ErrorAlCargarCondicionPago(this.error);
  @override
  List<Object> get props => [error];
}

