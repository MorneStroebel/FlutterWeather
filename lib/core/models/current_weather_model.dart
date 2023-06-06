class CurrentWeatherModel{

  final String cityName;
  final String country;
  final double temp;
  final int humidity;
  final int pressure;
  final double wind;

  CurrentWeatherModel({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.humidity,
    required this.pressure,
    required this.wind
});

  factory CurrentWeatherModel.fromMap(Map<String, dynamic> json) => CurrentWeatherModel(
    cityName: json['name'],
    country: json['sys']['country'],
    temp: json['main']['temp'],
    humidity: json['main']['humidity'],
    pressure: json['main']['pressure'],
    wind: json['wind']['speed'],
  );

  static List<CurrentWeatherModel> fromMapList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return CurrentWeatherModel.fromMap(json);
    }).toList();
  }

  Map<String, dynamic> toMap() => {
    'name': cityName,
    'country': country,
    'temp': temp,
    'humidity': humidity,
    'pressure': pressure,
    'speed': wind,
  };

  static dynamic getListMap(List<dynamic> weatherData){
    if(weatherData == null) return null;
    List<Map<String, dynamic>> listQuestions = [];
    for (var element in weatherData) {
      listQuestions.add(element.toMap());
    }
    return listQuestions;
  }

}