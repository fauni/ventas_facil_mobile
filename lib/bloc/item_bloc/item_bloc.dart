import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/item_bloc/item_event.dart';
import 'package:ventas_facil/bloc/item_bloc/item_state.dart';
import 'package:ventas_facil/models/producto/item.dart';
import 'package:ventas_facil/repository/item_repository.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState>{
  final ItemRepository _repository;

  ItemBloc(this._repository): super(ItemLoading()){
    on<LoadItems>(_onLoadItems);
  }

  Future<void> _onLoadItems(LoadItems event, Emitter<ItemState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();    

    final currentSate = state;
    List<Item> items = [];
    int newItemsStartIndex = 0;

    if(currentSate is ItemLoaded){
      items = currentSate.items;
      newItemsStartIndex = items.length;
    }
    emit(ItemLoading());
    try {
      final newItems = await _repository.getAllItemsParaVenta(token, event.text, top: event.top, skip: event.skip);
      emit(ItemLoaded(items + newItems, newItemsStartIndex: newItemsStartIndex));
    } catch(e){
      emit(ItemNotLoaded(e.toString()));
    }
  }
}