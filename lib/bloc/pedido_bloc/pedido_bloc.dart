import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_event.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';

class PedidoBloc extends Bloc<PedidoEvent, PedidoState>{
  final PedidoRepository _pedidoRepository;

  PedidoBloc(this._pedidoRepository): super(PedidosLoading()){
    on<LoadPedidos>(_onLoadPedidos);
    on<LoadPedidosSearch>(_onLoadPedidosSearch);
    on<SavePedido>(_onGuardarPedido);
    on<UpdatePedido>(_onUpdatePedido);
    on<UpdateEstadoLineaPedido>(_onUpdateEstadoLineaPedido);
  }

  Future<void> _onLoadPedidos(LoadPedidos event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosLoading());
    try {
      final pedidos = await _pedidoRepository.getOrdenesVentaAbiertos(token);
      emit(PedidosLoadedSearch(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosEmpty());
    }catch (e) {
      emit(PedidosNotLoaded(e.toString()));
    }
  }

  Future<void> _onLoadPedidosSearch(LoadPedidosSearch event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosLoading());
    try {
      final pedidos = await _pedidoRepository.getOrdenesForSearch(token, event.search);
      emit(PedidosLoadedSearch(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosEmpty());
    }catch (e) {
      emit(PedidosNotLoaded(e.toString()));
    }
  }

  Future<void> _onGuardarPedido(SavePedido event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidoGuardando());
    try {
      final pedidoGuardado = await _pedidoRepository.guardarPedido(token, event.pedido);
      emit(PedidoGuardadoExitoso(pedidoGuardado));
    } on UnauthorizedException catch(_){
      emit(PedidosUnauthorized());
    } catch (e) {
      emit(PedidoGuardadoError(e.toString()));
    }
  }

  Future<void> _onUpdatePedido(UpdatePedido event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidoModificando());
    try {
      final pedidoActualizado = await _pedidoRepository.modificarPedido(token, event.pedido);
      emit(PedidoModificadoExitoso(pedidoActualizado));
    } catch (e) {
      emit(PedidoModificadoError(e.toString()));
    }
  }

  Future<void> _onUpdateEstadoLineaPedido(UpdateEstadoLineaPedido event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(EstadoLineaPedidoModificando());
    try {
      final pedidoActualizado = await _pedidoRepository.modificarEstadoLineaPedido(token, event.pedido, event.item);
      emit(EstadoLineaPedidoModificadoExitoso(pedidoActualizado, event.item));
    } catch (e) {
      emit(EstadoLineaModificadoError(e.toString()));
    }
  }
}