class HomeViewModel {

  String animType(String weatherType) {
    if(weatherType == "few clouds" || weatherType == "scattered clouds" || weatherType == "broken clouds") return "assets/anim/cloudy.json";
    if(weatherType == "shower rain" || weatherType == "rain" || weatherType == "thunderstorm") return "assets/anim/rain.json";
    return "assets/anim/clear.json";
  }

}