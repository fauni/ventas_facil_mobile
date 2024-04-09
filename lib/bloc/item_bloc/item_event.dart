import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class LoadItems extends ItemEvent{
  String text;
  LoadItems({ required this.text });
}