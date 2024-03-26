import 'package:shared_preferences/shared_preferences.dart';

class GenericosService {
  Future<void> saveLocation(double latitude, double longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude);
    await prefs.setDouble('longitude', longitude);
  }

  Future<double?> getLatitud() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitud = prefs.getDouble('latitude');
    return latitud;
  }

  Future<double?> getLongitud() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? longitud = prefs.getDouble('longitude');
    return longitud;
  }
}