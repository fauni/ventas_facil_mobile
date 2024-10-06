import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/condicion_pago_bloc/condicion_pago_event.dart';
import 'package:ventas_facil/bloc/condicion_pago_bloc/condicion_pago_state.dart';
import 'package:ventas_facil/repository/condicion_pago_repository.dart';

class CondicionPagoBloc extends Bloc<CondicionPagoEvent, CondicionPagoState>{
  final CondicionPagoRepository _repository;

  CondicionPagoBloc(this._repository): super(CondicionPagoInicial()){
    on<CargarCondicionPago>(_onLoadCondicionesDePago);
    on<CargarCondicionPagoPorId>(_onLoadCondicionesDePagoPorId);
  }

  Future<void> _onLoadCondicionesDePago(CargarCondicionPago event, Emitter<CondicionPagoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(CargarCondicionPagoLoading());
    try {
      final datos = await _repository.getAllCondicionDePago(token);
      emit(CargarCondicionesPagoExitoso(datos));
    }catch (e) {
      emit(ErrorAlCargarCondicionPago(e.toString()));
    }
  }

  Future<void> _onLoadCondicionesDePagoPorId(CargarCondicionPagoPorId event, Emitter<CondicionPagoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(CargarCondicionPagoLoading());
    try {
      final pedidos = await _repository.getCondicionDePagoPorId(token, event.id);
      emit(CargarCondicionPagoExitoso(pedidos));
    }catch (e) {
      emit(ErrorAlCargarCondicionPago(e.toString()));
    }
  }
}