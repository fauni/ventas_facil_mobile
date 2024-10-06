
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/serie_numeracion_bloc/serie_numeracion_event.dart';
import 'package:ventas_facil/bloc/serie_numeracion_bloc/serie_numeracion_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/serie_numeracion/serie_numeracion.dart';
import 'package:ventas_facil/repository/serie_numeracion_repository.dart';

class SerieNumeracionBloc extends Bloc<SerieNumeracionEvent, SerieNumeracionState>{
  final SerieNumeracionRepository _serieNumeracionRepository;

  SerieNumeracionBloc(this._serieNumeracionRepository): super(SerieNumeracionInitial()){
    on<GetSerieNumeracionByIdDocument>(_onLoadSeriesNumeracionByDocument);
  }

  Future<void> _onLoadSeriesNumeracionByDocument(GetSerieNumeracionByIdDocument event, Emitter<SerieNumeracionState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(SerieNumeracionLoading());
    try {
      List<SerieNumeracion> series = await _serieNumeracionRepository.getSeriesNumeracionPorDocumento(token, event.tipoDocumento);
      emit(SerieNumeracionPorDocumentoLoaded(series));
    } on UnauthorizedException catch(_){
      emit(SerieNumeracionUnauthorized());
    } on GenericEmptyException catch(_){
      emit(SerieNumeracionEmpty());
    } catch(e){
      emit(SerieNumeracionError(e.toString()));
    }
  }
}