
import 'package:flutter/material.dart';

class App {
  final BuildContext _context;
  double _height = 0;
  double _width = 0;
  double _heightPadding = 0;
  double _widthPadding = 0;

  App(BuildContext context): _context = context;

  double appHeight(double v) {
    MediaQueryData queryData = MediaQuery.of(_context);
    _height = queryData.size.height / 100.0;
    return _height * v;
  }

  double appWidth(double v) {
    MediaQueryData queryData = MediaQuery.of(_context);
    _width = queryData.size.width / 100.0;
    return _width * v;
  }

  double appVerticalPadding(double v) {
    MediaQueryData queryData = MediaQuery.of(_context);
    _heightPadding = _height - ((queryData.padding.top + queryData.padding.bottom) / 100.0);
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    MediaQueryData queryData = MediaQuery.of(_context);
    _widthPadding = _width - ((queryData.padding.top + queryData.padding.bottom) / 100.0);
    return _widthPadding * v;
  }
  
}  


class Colors {
  Color mainColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFFFE8900).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFFE8900).withOpacity(opacity);
    }
  }

  Color floatingActionButtonPrimaryColor(){
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFFFE8900);
    } catch (e) {
      return const Color(0xFFFE8900);
    }
  }
  Color primaryColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFFFFA721).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFFFA721).withOpacity(opacity);
    }
  }
  Color secondaryColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFFFE8900).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFFE8900).withOpacity(opacity);
    }
  }

  Color accentColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFFA7B7BD).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFA7B7BD).withOpacity(opacity);
    }
  }

  Color splashColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFF7E84A3).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFF7E84A3).withOpacity(opacity);
    } 
  }
  Color blueIconColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFF57B8FF).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFF57B8FF).withOpacity(opacity);
    } 
  }

  Color greenIconColor(double opacity) {
    try {
      // return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
      return const Color(0xFF21D59B).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFF21D59B).withOpacity(opacity);
    } 
  }
}