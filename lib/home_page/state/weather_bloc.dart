import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';

import 'package:weather_project/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvents, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({
    required this.repository,
  }) : super(WeatherState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      final weather = await repository.getWeather(
        event.location,
      );

      emit(
        WeatherLoaded(
          weather: weather,
        ),
      );
    });
  }
}
