import 'package:equatable/equatable.dart';

abstract class SocioNegocioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSociosNegocio extends SocioNegocioEvent{}