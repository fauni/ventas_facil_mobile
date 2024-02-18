import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/producto/producto.dart';

abstract class ProductoState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductosLoading extends ProductoState {}

class ProductosLoaded extends ProductoState {
  final List<Producto> productos;

  ProductosLoaded(this.productos);

  @override
  List<Object> get props => [productos];
}

class ProductosNotLoaded extends ProductoState {
  final String error;

  ProductosNotLoaded(this.error);
  @override
  List<Object> get props => [error];
}

class ProductosUnauthorized extends ProductoState{}
class ProductosEmpty extends ProductoState{}
class ProductoError extends ProductoState{}