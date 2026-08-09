import 'dart:io';
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

          final localFlagPath = await _getFlagLocalPath(
            data.countryFlag.flagUrl,
            data.weather.country,
          );

          await database.insertCountry(
            country: data.weather.country,
            temperature: data.weather.temperature.toDouble(),
            flag: localFlagPath,
          );
        } else {
          emit(state.copyWith(
            status: WeatherStatusEnum.error,
            errorMessage: 'No internet connection',
          ));
          return;
        }

        final history = await database.getAllCountries();

        emit(WeatherState(
          status: WeatherStatusEnum.loaded,
          data: data,
          weatherHistory: history,
        ));
      } catch (error) {
        emit(WeatherState(
          status: WeatherStatusEnum.error,
          errorMessage: error.toString(),
        ));
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

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<String> _getFlagLocalPath(String flagUrl, String countryName) async {
    final response = await http.get(Uri.parse(flagUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to download flag image');
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${countryName.replaceAll(' ', '_')}_flag.png';
    final filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }
}
