import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/core/data/api/api.dart';
import 'package:flutter_weather/core/enums/sign_in_enum.dart';
import 'package:flutter_weather/core/models/current_weather_model.dart';
import 'package:flutter_weather/core/services/firebase_services.dart';
import 'package:flutter_weather/core/services/locationService.dart';
import 'package:location/location.dart';

class LoginViewModel {
  LocationService locationService = LocationService();
  FirebaseServices firebaseServices = FirebaseServices();
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  Future<bool> hasLocation() async {
    LocationData? locationData = await locationService.getLocation();
    if (locationData != null) return true;
    return false;
  }

  bool validEmail() {
    return EmailValidator.validate(emailTextController.text);
  }

  bool isEmpty() {
    if (emailTextController.text.isEmpty || passwordTextController.text.isEmpty) return true;
    return false;
  }

  Future<SignInEnum> signInWithEmail() async {
    if (isEmpty()) return SignInEnum.emptyFields;
    if (!validEmail()) return SignInEnum.inValidEmail;
    return await firebaseServices.emailSignIn(
        emailTextController.text, passwordTextController.text);
  }

}