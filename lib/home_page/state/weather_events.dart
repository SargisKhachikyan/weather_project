class WeatherEvents {}

class GetWeatherEvent extends WeatherEvents {
  final String location;

  GetWeatherEvent(this.location);
}
 