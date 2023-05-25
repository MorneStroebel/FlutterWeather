
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/views/loginScreen.dart';
import 'package:flutter_weather/views/splashScreen.dart';

class Routes {
  static const String splash = '/';
  static const String loginScreen = 'loginScreen';

  static Map<String, Widget Function(Object? params)> map = {
    splash: (Object? params) => const SplashScreen(),
    loginScreen: (Object? params) => const LoginScreen()
  };
}