import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/models/authentication/user.dart';
import 'package:ventas_facil/ui/pages/modulo_page.dart';
import 'package:ventas_facil/ui/pages/pedido/pedido_page.dart';
import 'package:ventas_facil/ui/pages/principal_page.dart';
import 'package:ventas_facil/ui/pages/settings_page.dart';
import 'package:ventas_facil/ui/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  int _selectedIndex = 0;

  User? user;


  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=> verificaSesion());

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final iconList = <IconData>[
    Icons.home,
    Icons.inventory,
    Icons.receipt,
    Icons.medical_information
  ];

  final iconTitle = <String>[
    'Inicio',
    'Inventario',
    'Pedidos',
    'Visita'
  ];

  final List<Widget> _pages = [
    const PrincipalPage(),
    const ModuloPage(),
    const PedidoPage(),
    const SettingsPage(),
    const ModuloPage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const DrawerWidget(),
      // appBar: AppBar(
      //   title: const Text('Home Page'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         BlocProvider.of<ThemeBloc>(context).add(ThemeToggle());
      //       }, 
      //       icon: const Icon(Icons.light_mode)
      //     ),
      //     IconButton(
      //       onPressed: (){
      //         logout();
      //       }, 
      //       icon: const Icon(Icons.logout)
      //     )
      //   ],
      // ),
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
           _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
          setState(() {
            _selectedIndex = 4;
          });
        }, 
        child: const Icon(Icons.menu_open),
      ),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (index, isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: isActive ? Colors.amber : Colors.blue
                ),
                const SizedBox(height: 4,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    iconTitle[index],
                    maxLines: 1,
                    style: TextStyle(color: isActive? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.inversePrimary),
                    group: AutoSizeGroup(),
                  ),
                )
              ],
            );
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          activeIndex: _selectedIndex,
          splashColor: Theme.of(context).splashColor,
          notchAndCornersAnimation: borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: _navigateBottomBar,
          hideAnimationController: _hideBottomBarAnimationController,
          shadow: BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Theme.of(context).secondaryHeaderColor
          ),
        ),
      ),
    );
  }

  Future<void> verificaSesion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if(userString != null){
      try {
        final Map<String, dynamic> userMap = jsonDecode(userString);
        user = User.fromJson(userMap);
        setState(() {});
      } catch (e) {
        context.go('/Login');
      }
    } else {
      context.go('/Login');
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    context.go('/Login');
  }
}