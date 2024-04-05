import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/unidad_medida_bloc/unidad_medida_event.dart';
import 'package:ventas_facil/bloc/unidad_medida_bloc/unidad_medida_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/repository/item_unidad_medida_repository.dart';

class UnidadMedidaBloc extends Bloc<UnidadMedidaEvent, UnidadMedidaState>{
  final ItemUnidadMedidaRepository _repository;

  UnidadMedidaBloc(this._repository): super(UnidadMedidaLoading()){
    on<LoadUnidadMedida>(_onLoadUnidadMedida);
  }

  Future<void> _onLoadUnidadMedida(LoadUnidadMedida event, Emitter<UnidadMedidaState> emit)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(UnidadMedidaLoading());
    try {
      final unidades = await _repository.getUnidadesDeMedida(token);
      emit(UnidadMedidaLoaded(unidades));
    } on UnauthorizedException catch(_){
      emit(UnidadMedidaUnauthorized());
    } catch(e){
      emit(UnidadMedidaNotLoaded(e.toString()));
    }
  }
}