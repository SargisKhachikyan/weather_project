import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';
import 'package:weather_project/service/locator/locator.dart';

import 'presentation/widgets/weather_city_search.dart';
import 'presentation/widgets/weather_location_header.dart';
import 'presentation/widgets/weather_summary.dart';
import 'presentation/widgets/weather_history_title.dart';
import 'presentation/widgets/weather_history_list.dart';
import 'presentation/widgets/weather_sky_background.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cityController = TextEditingController();
  late final Future<Directory> _flagDirectory =
      getApplicationDocumentsDirectory();

  void _search(BuildContext context) {
    final city = cityController.text.trim();
    if (city.isEmpty) return;
    context.read<WeatherBloc>().add(GetWeatherEvent(city));
    cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: weatherGetIt.get<WeatherBloc>(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          final weather = state.data?.weather;
          final loading = state.status == WeatherStatusEnum.loading;
          return Scaffold(
            backgroundColor: const Color(0xFF296897),
            body: Stack(
              children: [
                Positioned.fill(
                  child: WeatherSkyBackground(
                    background:
                        WeatherBackground.fromTemperature(weather?.temperature),
                  ),
                ),
                SafeArea(
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 620),
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                            children: [
                              WeatherCitySearch(
                                controller: cityController,
                                isLoading: loading,
                                onSearch: () => _search(context),
                              ),
                              if (loading)
                                const Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: LinearProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Color(0x22FFFFFF),
                                    minHeight: 2,
                                    semanticsLabel: 'Loading weather',
                                  ),
                                ),
                              if (state.status == WeatherStatusEnum.error)
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Semantics(
                                    liveRegion: true,
                                    child: const Text(
                                      'Unable to load weather. Check your connection and city name, then try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(height: 1.5),
                                    ),
                                  ),
                                ),
                              SizedBox(height: weather == null ? 64 : 56),
                              if (weather != null) ...[
                                WeatherLocationHeader(
                                  city: weather.name,
                                  country: weather.country,
                                  flagUrl: state.data!.countryFlag.flagUrl,
                                ),
                                const SizedBox(height: 28),
                                WeatherSummary(
                                    temperature: weather.temperature,
                                    windSpeed: weather.windSpeed,
                                    feelsLike: weather.feelsLike),
                              ] else
                                const Column(children: [
                                  Icon(Icons.cloud_outlined, size: 64),
                                  SizedBox(height: 24),
                                  Text(
                                    'Weather, simply.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Search for a city to get started.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFD9E8F4),
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                ]),
                              const SizedBox(height: 26),
                              WeatherHistoryTitle(
                                hasHistory: state.weatherHistory.isNotEmpty,
                                isLoading: loading,
                                onClear: () =>
                                    context.read<WeatherBloc>().add(ClearAll()),
                              ),
                              const SizedBox(height: 8),
                              WeatherHistoryList(
                                  history: state.weatherHistory,
                                  directory: _flagDirectory),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
