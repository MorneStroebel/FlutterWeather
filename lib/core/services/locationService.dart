import 'package:location/location.dart';

class LocationService {
  Location location = Location();


  Future<bool> isServiceEnabled() async {
    bool isEnabled = await location.serviceEnabled();
    if(isEnabled) return true;
    return isEnabled = await location.requestService();
  }

  Future<bool> hasPermission() async{
    PermissionStatus permissionStatus = await location.hasPermission();
    if(permissionStatus == PermissionStatus.granted) return true;
    permissionStatus = await location.requestPermission();
    return (permissionStatus == PermissionStatus.granted);
  }

  Future<LocationData?>? getLocation() async{
    bool userPermission = await hasPermission();
    bool isEnabled = await isServiceEnabled();
    if(userPermission && isEnabled){
      LocationData currentLocation = await location.getLocation();
      return currentLocation;
    }
    return null;
  }
}