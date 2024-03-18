import 'package:shared_preferences/shared_preferences.dart';

class GenericosService {
  Future<void> saveLocation(double latitude, double longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude);
    await prefs.setDouble('longitude', longitude);
  }

  Future<String> getLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');
    return '${latitude ?? 0.0}|${longitude ?? 0.0}';
  }
}