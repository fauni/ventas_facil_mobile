import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_facil/bloc/common_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_state.dart';
import 'package:ventas_facil/config/helpers/app_config.dart' as config;
import 'package:ventas_facil/config/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Ventas Facil',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: !state.isDark 
            ? ThemeData(
              brightness: Brightness.light, 
              primaryColor: config.Colors().naranja721Color(1),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                foregroundColor: config.Colors().blancoColor(1), 
                backgroundColor: config.Colors().naranja900Color(1), 
              ),
              dividerColor: config.Colors().amarilloA67Color(0.1),
              // Iconos sidebar, 
              focusColor: config.Colors().azul8FFColor(1),
              hintColor: config.Colors().azul8FFColor(1),
              colorScheme: ColorScheme(
                brightness: Brightness.light, 
                primary: config.Colors().naranja721Color(1), 
                // Letras del navigation bar unselected
                onPrimary: config.Colors().azul8FFColor(1), 
                secondary: config.Colors().azul8FFColor(1), 
                onSecondary: config.Colors().gris7BDColor(1), 
                error: config.Colors().verde59BColor(1), 
                onError: config.Colors().azul8FFColor(1), 
                // Fondo de toda la pantalla
                background: config.Colors().blancoColor(1), 
                // COlor de las lineas del input
                onBackground: config.Colors().gris7BDColor(1),  
                // Fondo de App bar, botones
                surface: config.Colors().blancoColor(1), 
                // color de texto general
                onSurface: config.Colors().textoGris4A3Color(1)
              ), 
            )
            : ThemeData(
              brightness: Brightness.dark
            ),
          );
        },
      )
    );
  }
}