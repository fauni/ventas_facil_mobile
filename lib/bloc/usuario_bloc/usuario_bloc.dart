import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/usuario_bloc/usuario_event.dart';
import 'package:ventas_facil/bloc/usuario_bloc/usuario_state.dart';
import 'package:ventas_facil/repository/usuarios_repository.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState>{
  final UsuariosRepository _usuariosRepository;

  UsuarioBloc(this._usuariosRepository) : super(UsuariosLoading()){
    on<LoadUsuarios>(_onLoadUsuarios);
    on<LoadLocalUsuarios>(_onLocalLoadUsuarios);
    on<LoadLastSyncDate>(_onLoadLastSyncDate);
  }

  Future<void> _onLoadLastSyncDate(LoadLastSyncDate event, Emitter<UsuarioState> emit) async {
    try {
      final DateTime? lastSyncDate = await _usuariosRepository.getLastSyncDate();
      if(lastSyncDate != null) {
        emit(LastSyncDateLoaded(lastSyncDate));
      } else {
        emit(LastSyncDateError());
      }
    } catch (e) {
      emit(LastSyncDateError());
    }
  }

  Future<void> _onLocalLoadUsuarios(LoadLocalUsuarios event, Emitter<UsuarioState> emit) async {
    emit(UsuariosLoading());
    try {
      final usuarios = await _usuariosRepository.getLocalUsuarios();     
      emit(UsuariosLoadLocalSuccess(usuarios));
    } catch (e) {
      emit(UsuariosNotLoaded(e.toString()));
    }
  }

  Future<void> _onLoadUsuarios(LoadUsuarios event, Emitter<UsuarioState> emit) async {
    emit(UsuariosLoading());
    try {
      final usuarios = await _usuariosRepository.fetchAndStoreUsuarios();
      final DateTime now = DateTime.now();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastSync', now.toIso8601String());

      emit(UsuariosLoaded(usuarios, now));
    } catch (e) {
      emit(UsuariosNotLoaded(e.toString()));
    }
  }
}