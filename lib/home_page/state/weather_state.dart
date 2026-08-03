import 'package:weather_project/models/all_models.dart';

enum WeatherStatusEnum { initial, loading, loaded, error }

class WeatherState {
  final WeatherStatusEnum status;
  final AllModels? data;
  final String? errorMessage;
  final List<Map<String, dynamic>> weatherHistory;

  WeatherState({
    this.status = WeatherStatusEnum.initial,
    this.data,
    this.errorMessage,
    this.weatherHistory = const [],
  });

  WeatherState copyWith({
    WeatherStatusEnum? status,
    AllModels? data,
    String? errorMessage,
    List<Map<String, dynamic>>? weatherHistory,
  }) {
    return WeatherState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      weatherHistory: weatherHistory ?? this.weatherHistory,
    );
  }
}
