import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/database/user_local_provider.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';

class PedidoPendienteBloc extends Bloc<PedidoPendienteEvent, PedidoPendienteState>{
  final PedidoRepository _pedidoRepository;

  PedidoPendienteBloc(this._pedidoRepository): super(PedidosPendientesInicial()){
    on<LoadPedidosPendientes>(_onLoadPedidos);
    on<LoadPedidosPendientesBySearch>(_onLoadPedidosSearch);
    on<LoadPedidosPendientesByDate>(_onLoadPedidosByDate);
    on<CrearDocumentoPedidoAprobado>(_onGuardarDocumentoPedidoAprobado);
  }

  Future<void> _onLoadPedidos(LoadPedidosPendientes event, Emitter<PedidoPendienteState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosPendientesLoading());
    try {
      final usuario = await getCurrentUser();
      final pedidos = event.status == 'Pendiente'
        ? await _pedidoRepository.getOrdenesPendientesAprobacion(token, usuario.userName!)
        : await _pedidoRepository.getOrdenesPendientesAprobados(token, '', usuario.userName!);
      emit(PedidosPendientesLoadedSearch(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosPendientesUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosPendientesEmpty());
    }catch (e) {
      emit(PedidosPendientesNotLoaded(e.toString()));
    }
  }

  Future<void> _onLoadPedidosSearch(LoadPedidosPendientesBySearch event, Emitter<PedidoPendienteState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosPendientesLoading());
    try {
      final usuario = await getCurrentUser();
      final pedidos = event.status == 'Pendiente'
      ? await _pedidoRepository.getOrdenesPendientesAprobacionBySearch(token, event.search, usuario.userName!)
      : await _pedidoRepository.getOrdenesPendientesAprobados(token, event.search, usuario.userName!);
      emit(PedidosPendientesLoadedSearch(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosPendientesUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosPendientesEmpty());
    }catch (e) {
      emit(PedidosPendientesNotLoaded(e.toString()));
    }
  }

  Future<void> _onLoadPedidosByDate(LoadPedidosPendientesByDate event, Emitter<PedidoPendienteState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(PedidosPendientesLoading());
    try {
      final usuario = await getCurrentUser();
      final pedidos = event.status == 'Pendiente'
      ? await _pedidoRepository.getOrdenesPendientesAprobacionByDate(token, event.date.toString(), usuario.userName!)
      : await _pedidoRepository.getOrdenesPendientesAprobadosByDate(token, event.date.toString(), usuario.userName!);
      emit(PedidosPendientesLoadedSearch(pedidos));
    } on UnauthorizedException catch(_){
      emit(PedidosPendientesUnauthorized());
    } on PedidosEmpty catch(_){
      emit(PedidosPendientesEmpty());
    }catch (e) {
      emit(PedidosPendientesNotLoaded(e.toString()));
    }
  }

  Future<void> _onGuardarDocumentoPedidoAprobado(CrearDocumentoPedidoAprobado event, Emitter<PedidoPendienteState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(CreacionPedidoAprobadoLoading());
    try {
      final documentoCreado = await _pedidoRepository.crearDocumentoAprobado(token, event.id);
      emit(CreacionPedidoAprobadoExitoso(documentoCreado));
    } catch (e) {
      emit(PedidosPendientesError(e.toString()));
    }
  }
} 