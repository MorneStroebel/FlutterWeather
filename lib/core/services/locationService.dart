import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();


  Future<bool> _isServiceEnabled() async {
    bool isEnabled = await _location.serviceEnabled();
    if(isEnabled) return true;
    return isEnabled = await _location.requestService();
  }

  Future<bool> _hasPermission() async{
    PermissionStatus permissionStatus = await _location.hasPermission();
    if(permissionStatus == PermissionStatus.granted) return true;
    permissionStatus = await _location.requestPermission();
    return (permissionStatus == PermissionStatus.granted);
  }

  Future<LocationData?> getLocation() async {
    bool userPermission = await _hasPermission();
    bool isEnabled = await _isServiceEnabled();
    if (!userPermission && !isEnabled) return null;
    LocationData currentLocation = await _location.getLocation();
    return currentLocation;
  }

}