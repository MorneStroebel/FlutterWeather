import 'package:flutter_weather/core/data/api/api.dart';
import 'package:flutter_weather/core/models/forecast_weather_model.dart';

class ForecastWeatherRepo{
  static Future<ForecastWeatherModel> getWeatherData(double? lon, double? lat) async {
    return  ForecastWeatherModel.fromJson(await Api.get("forecast?",lon, lat));
  }
}