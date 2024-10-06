import 'package:equatable/equatable.dart';

abstract class CondicionPagoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CargarCondicionPago extends CondicionPagoEvent{}

class CargarCondicionPagoPorId extends CondicionPagoEvent{
  final int id;
  CargarCondicionPagoPorId(this.id);
  @override
  List<Object> get props => [id]; 
}

