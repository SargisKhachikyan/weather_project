import 'package:weather_project/models/all_models.dart';
import 'package:weather_project/models/country_flag_model.dart';
import 'package:weather_project/service/country_code_api/country_code_api.dart';
import 'package:weather_project/service/country_flag_api.dart/country_flag_api.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';

class WeatherRepository {
  final WeatherApi weatherApi;
  final CountryCodeApi countryCodeApi;
  final CountryFlagApi countryFlagApi;

  WeatherRepository({
    required this.weatherApi,
    required this.countryCodeApi,
    required this.countryFlagApi,
  });

  Future<AllModels> getAllData(String city) async {
    final weather = await weatherApi.getWeather(city);

    final countryCode = await countryCodeApi.getCode(weather.country);

    final countryFlagUrl =
        countryFlagApi.getFlagUrl(countryCode.alphaCountryCode);
    final countryFlag = CountryFlagModel(flagUrl: countryFlagUrl);

    return AllModels(
      weather: weather,
      countryCode: countryCode,
      countryFlag: countryFlag,
    );
  }
}
