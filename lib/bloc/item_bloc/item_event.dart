import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadItems extends ItemEvent{
  String text;
  int top;
  int skip;
  LoadItems({ required this.text, this.top = 10, this.skip = 0});
}