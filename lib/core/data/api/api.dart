import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/core/utils/config.dart';

class Api {
  static String get _apiUrl => Config.apiUrl;
  static Future<dynamic> get(String type, double? lon, double? lat) async {
    var res = await Dio().get('$_apiUrl/$type''lon=$lon&lat=$lat&units=metric&APPID=${dotenv.env['ApiKey']}');
    return res.data;
  }
}