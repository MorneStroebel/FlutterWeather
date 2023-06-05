
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/src/views/create_account.dart';
import 'package:flutter_weather/src/views/forgot_password.dart';
import 'package:flutter_weather/src/views/homePage.dart';
import 'package:flutter_weather/src/views/loginScreen.dart';
import 'package:flutter_weather/src/views/no_location_permision.dart';
import 'package:flutter_weather/src/views/splashScreen.dart';


class Routes {
  static const String splash = '/';
  static const String loginScreen = 'loginScreen';
  static const String forgotPassword = 'forgotPassword';
  static const String signUp = 'signUp';
  static const String homePage = 'homePage';
  static const String noLocation = 'noLocation';

  static Map<String, Widget Function(Object? params)> map = {
    splash: (Object? params) => const SplashScreen(),
    loginScreen: (Object? params) => const LoginScreen(),
    forgotPassword: (Object? params) => ForgotPassword(),
    signUp: (Object? params) => CreateAccount(),
    homePage: (Object? params) => const HomePage(),
    noLocation: (Object? params) => const NoLocation(),
  };
}