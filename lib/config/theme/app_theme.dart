
import 'package:flutter/material.dart';
import 'package:ventas_facil/config/helpers/app_config.dart' as config;


const seedColor = Color.fromARGB(255, 7, 80, 59);

class AppTheme {

  final bool isDarkmode;

  AppTheme({ required this.isDarkmode });


  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: seedColor,

    brightness: isDarkmode ? Brightness.dark : Brightness.light,

    listTileTheme: const ListTileThemeData(
      iconColor: seedColor,
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: config.Colors().primaryColor(1),
      splashColor: config.Colors().splashColor(1)
    ),
    colorScheme:  ColorScheme.fromSeed(
      // primarySwatch: Colors.red,
      seedColor: config.Colors().mainColor(1),
      primary: config.Colors().mainColor(1),
      secondary: config.Colors().secondaryColor(1),
      tertiary: config.Colors().accentColor(1),
      inversePrimary: config.Colors().blueIconColor(1),
      inverseSurface: config.Colors().greenIconColor(1),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(color: config.Colors().accentColor(1), fontWeight: FontWeight.bold, fontSize: 14),
      titleMedium: TextStyle(color: config.Colors().accentColor(1), fontWeight: FontWeight.bold, fontSize: 16),
      titleLarge: TextStyle(color: config.Colors().accentColor(1), fontWeight: FontWeight.bold, fontSize: 22),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16
      )
    )
  );

}