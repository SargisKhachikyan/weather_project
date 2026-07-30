import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_get_button.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_results.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_text_field.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
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
            backgroundColor: const Color(0xFFF5F7FA),
            appBar: AppBar(
              backgroundColor: Colors.blue.shade400,
              title: Center(
                child: const Text(
                  'Weather App',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
                  const WeatherResult(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
