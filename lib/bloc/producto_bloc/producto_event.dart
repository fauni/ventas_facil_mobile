
import 'package:equatable/equatable.dart';

abstract class ProductoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductos extends ProductoEvent{}