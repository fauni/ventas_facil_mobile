import 'package:equatable/equatable.dart';

abstract class SocioNegocioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadSociosNegocio extends SocioNegocioEvent{
  int top;
  int skip;
  String text;
  LoadSociosNegocio({ required this.top, required this.skip, required this.text });
}