import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/presentation/widgets/home_page_main_widgets_data.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_get_button.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_text_field.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/home_page/state/weather_state.dart';
import 'package:weather_project/repository/weather_repository.dart';
import 'package:weather_project/service/country_flag_api.dart/country_flag_api.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';
import 'package:weather_project/service/country_code_api/country_code_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        repository: WeatherRepository(
          weatherApi: WeatherApi(),
          countryCodeApi: CountryCodeApi(),
          countryFlagApi: CountryFlagApi(),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFEAF4FF),
            appBar: AppBar(
              backgroundColor: const Color(0xFF2F80ED),
              title: Center(
                child: const Text(
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
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == WeatherStatusEnum.error) {
                        return Text(
                          'Sorry, something went wrong :(',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }

                      if (state.data != null) {
                        final weather = state.data!.weather;
                        final flag = state.data!.countryFlag.flagUrl;
                        final temperature = weather.temperature.toDouble();

                        return HomePageMainWidgetsData(
                          flag: flag,
                          weather: weather,
                          temperature: temperature,
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
