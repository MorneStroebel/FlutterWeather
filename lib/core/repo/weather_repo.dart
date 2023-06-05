import 'package:flutter_weather/core/data/api/api.dart';
import 'package:flutter_weather/core/models/weather_model.dart';

class WeatherRepo{
  static Future<WeatherModel> getWeatherData(double? lon, double? lat) async {
    return  WeatherModel.fromMap(await Api.get(lon, lat));
  }
}