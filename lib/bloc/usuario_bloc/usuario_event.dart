import 'package:equatable/equatable.dart';

abstract class UsuarioEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadUsuarios extends UsuarioEvent{}

class LoadLocalUsuarios extends UsuarioEvent{}

class LoadLastSyncDate extends UsuarioEvent{}
