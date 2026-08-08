import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';
import 'package:weather_project/models/all_models.dart';
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
        AllModels? data;
        final hasInternetConnection = await _hasInternetConnection();
        if (hasInternetConnection) {
          data = await repository.getAllData(event.location);
          final localPath = await _getFlagLocalPath(
              data.countryFlag.flagUrl, data.weather.country);

          await database.insertCountry(json: data.toJson(localPath));
        } else {
          //Get Map<String, Object?> city weather data
        }

        final history = await database.getAllCountries();

        emit(WeatherState(
          status: WeatherStatusEnum.loaded,
          data: data,
          weatherHistory: history, // добавлено
        ));
      } catch (error) {
        emit(WeatherState(
            status: WeatherStatusEnum.error, errorMessage: error.toString()));
      }
    });

    on<LoadWeatherEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: WeatherStatusEnum.loading));

        final history = await database.getAllCountries();

        emit(state.copyWith(
          status: WeatherStatusEnum.loaded,
          weatherHistory: history,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: WeatherStatusEnum.error,
          errorMessage: e.toString(),
        ));
      }
    });

    on<ClearAll>((event, emit) async {
      await database.clearAll();
      emit(WeatherState(
        status: WeatherStatusEnum.loaded,
        data: state.data,
        weatherHistory: [],
      ));
    });
  }

  Future<String> _getFlagLocalPath(String flagHttpPath, String city) async {
    final response = await http.get(Uri.parse(flagHttpPath));

    if (response.statusCode != 200) {
      throw Exception('Failed to download image');
    }

    final directory = await getApplicationDocumentsDirectory();

    final imageExtension = _getImageExtension(flagHttpPath);

    final file = File('${directory.path}/${city}_image.$imageExtension');

    await file.writeAsBytes(response.bodyBytes);

    return file.path;
  }

  String _getImageExtension(String path) {
    final uri = Uri.parse(path);
    final fileName = uri.pathSegments.last;

    return fileName.split('.').last.toLowerCase();
  }

  Future<bool> _hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }
}
