import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/producto/item.dart';

abstract class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemLoading extends ItemState{}

class ItemLoaded extends ItemState{
  final List<Item> items;
  final int newItemsStartIndex;

  ItemLoaded(this.items, {this.newItemsStartIndex = 0});

  @override
  List<Object?> get props => [items];
}

class ItemNotLoaded extends ItemState {
  final String error;

  ItemNotLoaded(this.error);
  @override
  List<Object?> get props => [error];
}