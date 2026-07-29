import 'package:get_it/get_it.dart';
import 'package:weather_project/service/country_code_api/country_code_api.dart';
import 'package:weather_project/service/country_flag_api.dart/country_flag_api.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';

final getitInstance = GetIt.instance;

void setupLocator() {
  getitInstance.registerLazySingleton(() => WeatherApi());
  getitInstance.registerLazySingleton(() => CountryFlagApi());
  getitInstance.registerLazySingleton(() => CountryCodeApi());
}
