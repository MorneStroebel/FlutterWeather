import 'package:flutter_weather/core/data/api/api.dart';
import 'package:flutter_weather/core/models/current_weather_model.dart';

class CurrentWeatherRepo{
  static Future<CurrentWeatherModel> getWeatherData(double? lon, double? lat) async {
    return  CurrentWeatherModel.fromMap(await Api.get("forecast",lon, lat));
  }
}