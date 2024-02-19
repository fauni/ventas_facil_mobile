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
  }

  Future<void> _onLoadPedidos(LoadPedidos event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosLoading());
    try {
      final pedidos = await _pedidoRepository.getAllVentas(token);
      emit(PedidosLoaded(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosEmpty());
    }catch (e) {
      emit(PedidosNotLoaded(e.toString()));
    }
  }
}