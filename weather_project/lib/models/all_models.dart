import 'package:weather_project/models/weather_model.dart';
import 'package:weather_project/models/country_code_model.dart';
import 'package:weather_project/models/country_flag_model.dart';
import 'package:weather_project/service/constants/db_constants.dart';

class AllModels {
  final WeatherModel weather;
  final CountryCodeModel countryCode;
  final CountryFlagModel countryFlag;

  const AllModels({
    required this.weather,
    required this.countryCode,
    required this.countryFlag,
  });

  Map<String, Object?> toJson(String localPath) {
    return {
      DbConstants.cityName: weather.country,
      DbConstants.windSpeed: weather.windSpeed,
      DbConstants.flagLocalPath: localPath,
      DbConstants.temp: weather.temperature,
    };
  }
}
