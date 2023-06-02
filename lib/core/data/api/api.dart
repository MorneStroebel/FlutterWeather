import 'package:dio/dio.dart';
import 'package:flutter_weather/core/utils/config.dart';

class Api {
  static String get _apiUrl => Config.apiUrl;
  static Future<dynamic> get(String route) async {
    var res = await Dio().get('$_apiUrl/$route');
    return res.data;
  }
}