import 'package:flutter_weather/core/models/current_weather_model.dart';
import 'package:flutter_weather/core/repo/current_weather_repo.dart';
import 'package:rxdart/subjects.dart';

class CurrentWeatherBlock {
  double? lat;
  double? lon;

  CurrentWeatherBlock({
    this.lon,
    this.lat
  });

  final _subject = BehaviorSubject<CurrentWeatherModel>();

  Stream<CurrentWeatherModel> get streamWeatherData => _subject.stream;
  Function(CurrentWeatherModel) get _addWeatherData => _subject.sink.add;

  Future<void> getData() async {
    _addWeatherData(await CurrentWeatherRepo.getWeatherData(lon, lat));
  }

  dispose() {
    _subject.close();
  }
}