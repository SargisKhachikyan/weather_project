import 'package:weather_project/models/all_models.dart';

enum WeatherStatusEnum { initial, loading, loaded, error }
class WeatherState {
  final WeatherStatusEnum status;
  final AllModels? data;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatusEnum.initial,
    this.data,
    this.errorMessage,
  });

  WeatherState copyWith({
    WeatherStatusEnum? status,
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