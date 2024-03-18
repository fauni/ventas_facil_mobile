
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Los servicios de ubicación están dehabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Los permisos de ubicación fueron denegados');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
    }

    return await Geolocator.getCurrentPosition();
  }
}