import 'package:flutter_weather/core/models/weather_model.dart';
import 'package:flutter_weather/core/repo/weather_repo.dart';
import 'package:rxdart/subjects.dart';

class WeatherBlock {
  double? lat;
  double? lon;

  WeatherBlock({
    this.lon,
    this.lat
  });

  final _subject = BehaviorSubject<WeatherModel>();

  Stream<WeatherModel> get streamWeatherData => _subject.stream;
  Function(WeatherModel) get _addWeatherData => _subject.sink.add;

  Future<void> getData() async {
    _addWeatherData(await WeatherRepo.getWeatherData(lon, lat));
  }

  dispose() {
    _subject.close();
  }
}