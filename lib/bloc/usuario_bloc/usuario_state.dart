import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/usuario.dart';

abstract class UsuarioState extends Equatable{
  @override
  List<Object> get props => [];
}

class UsuariosLoading extends UsuarioState {}

class UsuariosLoaded extends UsuarioState {
  final List<Usuario> usuarios;
  final DateTime lastSynced;

  UsuariosLoaded(this.usuarios, this.lastSynced);

  @override
  List<Object> get props => [usuarios, lastSynced];
}


class UsuariosNotLoaded extends UsuarioState{
  final String error;

  UsuariosNotLoaded(this.error);

  @override
  List<Object> get props => [error];
}

class UsuariosLoadLocalSuccess extends UsuarioState{
  final List<Usuario> usuarios;
  UsuariosLoadLocalSuccess(this.usuarios);
  @override
  List<Object> get props => [usuarios];
}


class LastSyncDateLoaded extends UsuarioState {
  final DateTime lastSyncDate;

  LastSyncDateLoaded(this.lastSyncDate);

  @override
  List<Object> get props => [lastSyncDate];
}

class LastSyncDateError extends UsuarioState {}
