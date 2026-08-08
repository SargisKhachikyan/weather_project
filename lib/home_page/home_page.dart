import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/presentation/widgets/home_page_main_widgets_data.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_get_button.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_seach_history_button_clear.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_search_history_list.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_text_field.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';
import 'package:weather_project/service/locator/locator.dart';
import 'package:weather_project/service/weather_database/weather_database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(LoadWeatherEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await weatherGetIt.get<WeatherDatabase>().deleteDb();
      },
      child: BlocProvider.value(
        value: weatherGetIt.get<WeatherBloc>(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: const Color(0xFFEAF4FF),
              appBar: AppBar(
                backgroundColor: const Color(0xFF2F80ED),
                title: const Center(
                  child: Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Check the weather',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          WeatherTextField(
                            controller: cityController,
                          ),
                          const SizedBox(height: 14),
                          WeatherGetButton(
                            onPressed: () {
                              final city = cityController.text.trim();

                              if (city.isEmpty) return;

                              context.read<WeatherBloc>().add(
                                    GetWeatherEvent(city),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state.status == WeatherStatusEnum.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.status == WeatherStatusEnum.error) {
                          return Text(
                            'Sorry, something went wrong :(',
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }

                        if (state.data != null) {
                          final weather = state.data!.weather;
                          final flag = state.data!.countryFlag.flagUrl;

                          return HomePageMainWidgetsData(
                            flag: flag,
                            weather: weather,
                            temperature: weather.temperature.toDouble(),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 24),
                    WeatherSearchHistoryButtonClear(),
                    const SizedBox(height: 24),
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        final history = state.weatherHistory;

                        if (history.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('No history'),
                          );
                        }

                        return WeatherSearchHistoryList();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
