import 'package:weather_project/models/weather_model.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';

class WeatherRepository {
  final WeatherApi weatherApiClient;

  WeatherRepository({required this.weatherApiClient});

  Future<WeatherModel> getWeather(String city) async {
    return await weatherApiClient.getWeather(city);
  }


}
