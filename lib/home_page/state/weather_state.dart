import 'package:weather_project/models/weather_model.dart';

class WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded({required this.weather});
}

class WeatherLoading extends WeatherState {}  
