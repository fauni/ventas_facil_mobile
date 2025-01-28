import 'package:equatable/equatable.dart';

abstract class UnidadMedidaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadUnidadMedida extends UnidadMedidaEvent{
  LoadUnidadMedida();
}

class CargarUnidadesDeMedida extends UnidadMedidaEvent{
  final String itemCode;
  CargarUnidadesDeMedida(this.itemCode);
}