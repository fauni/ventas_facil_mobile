import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';

class PedidoRechazadoBloc extends Bloc<PedidoRechazadoEvent, PedidoRechazadoState>{
  final PedidoRepository _pedidoRepository;

  PedidoRechazadoBloc(this._pedidoRepository): super(PedidosRechazadosInicial()){
    on<LoadPedidosRechazadosBySearch>(_onLoadPedidosRechazadosBySearch);
    on<LoadPedidosRechazadosByDate>(_onLoadPedidorechazadosByDate);
  }

  Future<void> _onLoadPedidosRechazadosBySearch(LoadPedidosRechazadosBySearch event, Emitter<PedidoRechazadoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosRechazadosLoading());
    try{
      final usuario = await getCurrentUser();
      final pedidos = await _pedidoRepository.getOrdenesPendientesRechazadosBySearch(token, event.search, usuario.userName!);
      emit(PedidosRechazadosLoaded(pedidos));
    } catch(e){
      if(e.toString().contains("Instance of 'UnauthorizedException'")) {
        emit(PedidosRechazadosUnauthorized());
      } else {
        emit(PedidosRechazadosNotLoaded(e.toString()));
      }
    
    } 
  }

  Future<void> _onLoadPedidorechazadosByDate(LoadPedidosRechazadosByDate event, Emitter<PedidoRechazadoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosRechazadosLoading());
    try{
      final usuario = await getCurrentUser();
      // TODO: Revisar parametro de entrada event.date
      final pedidos = await _pedidoRepository.getOrdenesPendientesRechazadosByDate(token, event.date.toString(), usuario.userName!);
      emit(PedidosRechazadosLoaded(pedidos));
    } catch(e){
      if(e.toString().contains("Instance of 'UnauthorizedException'")) {
        emit(PedidosRechazadosUnauthorized());
      } else {
        emit(PedidosRechazadosNotLoaded(e.toString()));
      }
    }
  }
}