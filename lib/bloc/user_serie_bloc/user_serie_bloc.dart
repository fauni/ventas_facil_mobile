import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/user_serie_bloc/user_serie_event.dart';
import 'package:ventas_facil/bloc/user_serie_bloc/user_serie_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';
import 'package:ventas_facil/repository/user_serie_repository.dart';

class UserSerieBloc extends Bloc<UserSerieEvent, UserSerieState>{
  final UserSerieRepository _userSerieRepository;

  UserSerieBloc(this._userSerieRepository): super(UserSerieInitial()){
    on<GetUserSerieByUser>(_onLoadUserSerieByUser);
  }

  Future<void> _onLoadUserSerieByUser(GetUserSerieByUser event, Emitter<UserSerieState> emit) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = prefs.get('token').toString();
    emit(UserSerieLoading());
    try {
      List<UserSerie> series = await _userSerieRepository.getUserSerieByUser(event.idUsuario);
      emit(UserSerieLoaded(series));
    } on UnauthorizedException catch(_){
      emit(UserSerieUnauthorized());
    } on GenericEmptyException catch(_){
      emit(UserSerieEmpty());
    } catch(e){
      emit(UserSerieError(e.toString()));
    }
  }
}