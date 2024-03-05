import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_facil/bloc/common_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_bloc.dart';
import 'package:ventas_facil/bloc/theme_bloc/theme_state.dart';
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
              brightness: Brightness.light
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