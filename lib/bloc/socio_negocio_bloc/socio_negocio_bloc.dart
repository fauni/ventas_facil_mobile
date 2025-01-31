import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/repository/socio_negocio_repository.dart';

class SocioNegocioBloc extends Bloc<SocioNegocioEvent, SocioNegocioState>{
  final SocioNegocioRepository _repository;

  SocioNegocioBloc(this._repository): super	(SocioNegocioLoading()){
    on<LoadSociosNegocio>(_onLoadSociosNegocio);
  }

  Future<void> _onLoadSociosNegocio(LoadSociosNegocio event, Emitter<SocioNegocioState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();    

    final currentState = state;
    List<SocioNegocio> clientes = [];
    int newItemsStartIndex = 0;

    if(currentState is SocioNegocioLoaded){
      clientes = currentState.clientes;
      newItemsStartIndex = clientes.length;
    }

    emit(SocioNegocioLoading());
    try { 
      final clientesNuevos = await _repository.getAllSocioNegocio(token, event.top, event.skip, event.text);
      emit(SocioNegocioLoaded(clientes + clientesNuevos, newItemsStartIndex: newItemsStartIndex));
    } on UnauthorizedException catch(_){
      emit(SocioNegocioUnauthorized());
    } catch(e){
      emit(SocioNegocioNotLoaded(e.toString()));
    }
  }
}