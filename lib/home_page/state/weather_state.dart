import 'package:weather_project/models/all_models.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState {
  final WeatherStatus status;
  final AllModels? data;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.data,
    this.errorMessage,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    AllModels? data,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}