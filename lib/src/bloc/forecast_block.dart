import 'package:flutter_weather/core/models/forecast_weather_model.dart';
import 'package:flutter_weather/core/repo/forecast_repo.dart';
import 'package:rxdart/subjects.dart';

class ForecastWeatherBloc {
  double? lat;
  double? lon;

  ForecastWeatherBloc({
    this.lon,
    this.lat,
  });
  final _subject = BehaviorSubject<ForecastWeatherModel>();

  Stream<ForecastWeatherModel> get streamWeatherData => _subject.stream;
  Function(ForecastWeatherModel) get _addWeatherData => _subject.sink.add;

  Future<void> getData() async {
    _addWeatherData(await ForecastWeatherRepo.getWeatherData(lon, lat));
  }

  dispose() {
    _subject.close();
  }
}