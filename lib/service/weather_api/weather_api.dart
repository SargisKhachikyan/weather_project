import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_project/models/weather_model.dart';

class WeatherApi {
  static const String _baseUrl = 'http://api.weatherstack.com/current';
  static const String _apiKey = 'd23331b49cd6543ac4e2dd2a7a7ddd7e';

  Future<WeatherModel> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?access_key=$_apiKey&query=$city'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load weather data(ERROR: ${response.statusCode})');
    }

    print('+++++Response status code: ${response.statusCode}');
    print('+++++Response body: ${response.body}');
    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}
