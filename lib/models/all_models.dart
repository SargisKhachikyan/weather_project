import 'package:weather_project/models/weather_model.dart';
import 'package:weather_project/models/country_code_model.dart';
import 'package:weather_project/models/country_flag_model.dart';

class AllModels {
  final WeatherModel weather;
  final CountryCodeModel countryCode;
  final CountryFlagModel countryFlag;

  const AllModels({
    required this.weather,
    required this.countryCode,
    required this.countryFlag,
  });

}
