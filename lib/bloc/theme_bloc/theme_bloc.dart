
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_event.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  ThemeBloc(): super(ThemeState(themeData: ThemeData.light(), isDark:false)){
    on<ThemeToggle>((event, emit) {
      final isDark = !state.isDark;      
      emit(ThemeState(themeData: isDark ? ThemeData.dark() : ThemeData.light(), isDark: isDark));
    },);
  }
}