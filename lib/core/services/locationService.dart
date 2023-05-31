import 'package:flutter_weather/core/enums/locationEnums.dart';
import 'package:location/location.dart';

Future<LocationPermissionsState> checkLocationPermission() async{
  bool serviceEnabled;
  PermissionStatus permissionStatus;
  Location location = Location();

  serviceEnabled = await location.serviceEnabled();
  if(!serviceEnabled){
    return LocationPermissionsState.notEnabled;
  }

  permissionStatus = await location.hasPermission();
  if(permissionStatus == PermissionStatus.denied){
    permissionStatus = await location.requestPermission();
    if(permissionStatus == PermissionStatus.denied){
      return LocationPermissionsState.denied;
    }
    if(permissionStatus == PermissionStatus.deniedForever){
      return LocationPermissionsState.permanentDisabled;
    }
  }
  return LocationPermissionsState.enabled;
}