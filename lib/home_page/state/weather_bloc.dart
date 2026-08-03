import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';
import 'package:weather_project/repository/weather_repository.dart';
import 'package:weather_project/service/weather_database/weather_database.dart';

class WeatherBloc extends Bloc<WeatherEvents, WeatherState> {
  final WeatherRepository repository;
  final WeatherDatabase database;

  WeatherBloc({
    required this.repository,
    required this.database,
  }) : super(WeatherState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherState(status: WeatherStatusEnum.loading));

      try {
        final data = await repository.getAllData(event.location);

        await database.insertCountry(
          country: event.location,
          temperature: data.weather.temperature.toDouble(),
          flag: data.countryFlag.flagUrl,
        );

        emit(WeatherState(status: WeatherStatusEnum.loaded, data: data));
      } catch (error) {
        emit(WeatherState(
            status: WeatherStatusEnum.error, errorMessage: error.toString()));
      }
    });
    on<LoadWeatherEvent>((event, emit) async {
      final data = await repository.getAllData(event.location);

      emit(WeatherState(status: WeatherStatusEnum.loading)
        ..copyWith(
          status: WeatherStatusEnum.loaded,
          data: data,
        ));
    });
  }
}
