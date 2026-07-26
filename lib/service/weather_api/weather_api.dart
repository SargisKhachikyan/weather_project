import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_project/models/weather_model.dart';

class WeatherApi {
  static const String _baseUrl = 'https://api.weatherstack.com/current';
  static const String _apiKey = '6e6aec6843ed3cf3ca335f17e16ef671';

  Future<WeatherModel> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?access_key=$_apiKey&query=$city'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load weather data(ERROR: ${response.statusCode})');
    }

    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}
