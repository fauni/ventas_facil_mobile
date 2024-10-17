
import 'package:equatable/equatable.dart';
import 'package:ventas_facil/models/serie_numeracion/user_serie.dart';

abstract class UserSerieState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSerieInitial extends UserSerieState{}

class UserSerieLoading extends UserSerieState{}

class UserSerieLoaded extends UserSerieState {
  final List<UserSerie> series;
  UserSerieLoaded(this.series);
}

class UserSerieError extends UserSerieState {
  final String message;

  UserSerieError(this.message);
  @override
  List<Object> get props => [message];
}

class UserSerieUnauthorized extends UserSerieState{}
class UserSerieEmpty extends UserSerieState{}
