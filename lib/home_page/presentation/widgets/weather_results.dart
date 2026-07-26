import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/home_page/state/weather_state.dart';

class WeatherResult extends StatelessWidget {
  const WeatherResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return CircularProgressIndicator();
        }

        if (state is WeatherLoaded) {
          final weather = state.weather;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Type: ${weather.type}',
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                'Query: ${weather.query}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Language: ${weather.language}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Unit: ${weather.unit}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Name: ${weather.name}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Country: ${weather.country}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Region: ${weather.region}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'TimezoneId: ${weather.timezoneId}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'Temperature: ${weather.temperature}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'FeelsLike: ${weather.feelsLike}',
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'WindSpeed: ${weather.windSpeed}',
                style: const TextStyle(fontSize: 22),
              ),
            ],
          );
        }

        return const Text('Enter city name');
      },
    );
  }
}
