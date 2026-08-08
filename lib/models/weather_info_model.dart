import 'package:weather_project/models/weather_model.dart';
import 'package:weather_project/models/country_code_model.dart';

class WeatherInfoModel {
  final WeatherModel weather;
  final CountryCodeModel countryCode;
  final String countryFlagUrl = 'https://flagsapi.com/flat/64.png';

  const WeatherInfoModel({
    required this.weather,
    required this.countryCode,
  });
}
