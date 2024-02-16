import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeData themeData;

  ThemeChanged({ required this.themeData });
}

class ThemeToggle extends ThemeEvent{}