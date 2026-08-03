import 'package:get_it/get_it.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/repository/weather_repository.dart';
import 'package:weather_project/service/country_code_api/country_code_api.dart';
import 'package:weather_project/service/country_flag_api.dart/country_flag_api.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';
import 'package:weather_project/service/weather_database/weather_database.dart';

final weatherGetIt = GetIt.instance;

class Locator {
  Future<void> registerDependencies() async {
    weatherGetIt.registerLazySingleton<CountryCodeApi>(
      () => CountryCodeApi(),
    );

    weatherGetIt.registerLazySingleton<CountryFlagApi>(
      () => CountryFlagApi(),
    );

    weatherGetIt.registerLazySingleton<WeatherApi>(() => WeatherApi());

    weatherGetIt.registerLazySingleton<WeatherDatabase>(
      () => WeatherDatabase(),
    );

    weatherGetIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepository(
        weatherApi: weatherGetIt(),
        countryCodeApi: weatherGetIt(),
        countryFlagApi: weatherGetIt(),
      ),
    );

    weatherGetIt.registerLazySingleton<WeatherBloc>(
      () => WeatherBloc(
        repository: weatherGetIt.get<WeatherRepository>(),
        database: weatherGetIt.get<WeatherDatabase>(),
      ),
    );
  }
}
