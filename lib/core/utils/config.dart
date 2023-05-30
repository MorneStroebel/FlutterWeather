import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/core/enums/environment.dart';

class Config{
  static const String _path = 'assets/config';
  static late String _apiUrl;
  static late String _environment;
  static late String? _email;
  static late String? _password;

  static Environment get environment => _stringToEnvironment();
  static bool get isDevelopment => environment == Environment.development;
  static String get email => _email ?? '';
  static String get password => _password ?? '';
  static String get apiUrl => _apiUrl;

  static Future<void> init() async{
    final configFile = await rootBundle.loadString('$_path/config.json');
    final json = jsonDecode(configFile);
    _environment = json["environment"] ?? 'd';

    switch (environment) {
      case Environment.development:
        await _asignVar('$_path/dev_config.json');
        break;
      case Environment.staging:
        await  _asignVar('$_path/staging_config.json');
        break;
      case Environment.production:
        _apiUrl = json['api_url'];
        break;
    }
  }

  static Future<void> _asignVar(String file) async{
    final envConfig = await rootBundle.loadString(file);
    final envJson = jsonDecode(envConfig);
    _email = envJson['email'];
    _password = envJson['password'];
    _apiUrl = envJson['api_url'];
  }

  static Environment _stringToEnvironment(){
    switch(_environment.toLowerCase()){
      case 'd':
        return Environment.development;
      case 's':
        return Environment.staging;
      case 'p':
        return Environment.production;
      default:
        return Environment.development;
    }
  }

}