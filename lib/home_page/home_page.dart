import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_get_button.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_results.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_text_field.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';
import 'package:weather_project/repository/weather_repository.dart';
import 'package:weather_project/service/weather_api/weather_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        repository: WeatherRepository(
          weatherApiClient: WeatherApi(),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('Weather app'),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeatherTextField(
                    controller: cityController,
                  ),
                  const SizedBox(height: 12),
                  WeatherGetButton(
                    onPressed: () {
                      final city = cityController.text.trim();

                      if (city.isEmpty) return;

                      context.read<WeatherBloc>().add(
                            GetWeatherEvent(city),
                          );
                    },
                  ),
                  const SizedBox(height: 20),
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
