import 'package:equatable/equatable.dart';

abstract class UnidadMedidaFacturaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTfeUnidadMedida extends UnidadMedidaFacturaEvent{
  LoadTfeUnidadMedida();
}