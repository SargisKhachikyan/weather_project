class WeatherEvents {}

class GetWeatherEvent extends WeatherEvents {
  final String location;

  GetWeatherEvent(this.location);
}

class LoadWeatherEvent extends WeatherEvents {
  final String location;

  LoadWeatherEvent(this.location);
}
