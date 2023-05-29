
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/views/create_account.dart';
import 'package:flutter_weather/views/forgot_password.dart';
import 'package:flutter_weather/views/loginScreen.dart';
import 'package:flutter_weather/views/splashScreen.dart';

class Routes {
  static const String splash = '/';
  static const String loginScreen = 'loginScreen';
  static const String forgotPassword = 'forgotPassword';
  static const String signUp = 'signUp';

  static Map<String, Widget Function(Object? params)> map = {
    splash: (Object? params) => const SplashScreen(),
    loginScreen: (Object? params) => const LoginScreen(),
    forgotPassword: (Object? params) => ForgotPassword(),
    signUp: (Object? params) => CreateAccount(),
  };
}