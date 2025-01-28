import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/repository/item_unidad_medida_repository.dart';

class UnidadMedidaFacturaBloc extends Bloc<UnidadMedidaFacturaEvent, UnidadMedidaFacturaState>{
  final ItemUnidadMedidaRepository _repository;

  UnidadMedidaFacturaBloc(this._repository): super(TfeUnidadMedidaLoading()){
    on<LoadTfeUnidadMedida>(_onLoadTfeUnidadMedida);
  }

  Future<void> _onLoadTfeUnidadMedida(LoadTfeUnidadMedida event, Emitter<UnidadMedidaFacturaState> emit)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(TfeUnidadMedidaLoading());
    try {
      final unidades = await _repository.getTfeUnidadesDeMedida(token);
      emit(TfeUnidadMedidaLoaded(unidades));
    } on UnauthorizedException catch(_){
      emit(TfeUnidadMedidaUnauthorized());
    } catch(e){
      emit(TfeUnidadMedidaNotLoaded(e.toString()));
    }
  }
}