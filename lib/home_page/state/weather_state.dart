import 'package:weather_project/models/all_models.dart';

class WeatherState {}

class WeatherLoaded extends WeatherState {
  final AllModels data;

  WeatherLoaded({required this.data});
}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
