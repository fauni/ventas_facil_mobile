import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_event.dart';
import 'package:ventas_facil/bloc/pedido_bloc/pedido_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/repository/pedido_repository.dart';

class PedidoBloc extends Bloc<PedidoEvent, PedidoState>{
  final PedidoRepository _pedidoRepository;

  PedidoBloc(this._pedidoRepository): super(ReporteInicial()){
    on<LoadPedidos>(_onLoadPedidos);
    on<LoadPedidosSearch>(_onLoadPedidosSearch);
    on<SavePedido>(_onGuardarPedido);
    on<UpdatePedido>(_onUpdatePedido);
    on<UpdateEstadoLineaPedido>(_onUpdateEstadoLineaPedido);
    on<DescargarYGuardarReportePedidoVenta>(_mapDownloadReportToState);
    on<DescargarReportePedidoVenta>(_mapDescargaYMuestraReporte);
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
      final pedidoGuardado = await _pedidoRepository.guardarPedido2(token, event.pedido);
      if(pedidoGuardado){
        emit(PedidoGuardadoExitoso(Pedido(linesPedido: [])));
      } else {
        throw Exception("No se pudo guardar");
      }
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

  Future<void> _mapDownloadReportToState(DescargarYGuardarReportePedidoVenta event, Emitter<PedidoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(ReporteDescargaEnProgreso(0));
    if(await _requestPermissions()){
      try {
        final filePath = await _pedidoRepository.downloadReport(token, event.id);
        emit(ReporteDescargaCorrecta(filePath));
        // final result = await OpenFile.open(filePath);
        // if (result.type != ResultType.done) {
        //   emit(ReporteDescargaFallida("No se pudo abrir el archivo: ${result.message}"));
        // } else {
        //   // Aquí puedes agregar lógica adicional si la apertura del archivo fue exitosa
        // }
      } catch (error) {
        emit(ReporteDescargaFallida(error.toString()));
      }
    } else {
      emit(ReporteDescargaFallida("No se concedio los permisos necesarios para la descarga"));
    }
  }

  Future<void> _mapDescargaYMuestraReporte(DescargarReportePedidoVenta event, Emitter<PedidoState> emit) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('token').toString();
  emit(ReporteDescargaEnProgreso(0));
  if (await _requestPermissions()) {
    try {
      // Aquí, en lugar de obtener una ruta de archivo, obtenemos directamente los bytes del PDF.
      final pdfBytes = await _pedidoRepository.fetchReportePDF(token, event.id);
      if(pdfBytes != null){
        emit(MostrarReporteDescargaCorrecta(pdfBytes));
      } else {
        emit(ReporteDescargaFallida("No se recibio correctamente los datos"));
      }

      // Navegamos a la pantalla del visor de PDF
    } catch (error) {
      emit(ReporteDescargaFallida(error.toString()));
    }
  } else {
    emit(ReporteDescargaFallida("No se concedieron los permisos necesarios para la descarga"));
  }
}

  Future<bool> _requestPermissions() async {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      var result = await Permission.storage.request();
      return result.isGranted;
    }
    return true;
  }
  
}