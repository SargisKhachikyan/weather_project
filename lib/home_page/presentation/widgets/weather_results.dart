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
        switch (state.status) {
          case WeatherStatusEnum.loading:
            return const CircularProgressIndicator();

          case WeatherStatusEnum.loaded:
            final weather = state.data!.weather;
            final countryFlag = state.data!.countryFlag;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(countryFlag.flagUrl, width: 64, height: 64),
                Text(' Name: ${weather.query}',
                    style: const TextStyle(fontSize: 22)),
                Text('Language: ${weather.language}',
                    style: const TextStyle(fontSize: 22)),
                Text('Unit: ${weather.unit}',
                    style: const TextStyle(fontSize: 22)),
                Text('Name: ${weather.name}',
                    style: const TextStyle(fontSize: 22)),
                Text('Country: ${weather.country}',
                    style: const TextStyle(fontSize: 22)),
                Text('Region: ${weather.region}',
                    style: const TextStyle(fontSize: 22)),
                Text('TimezoneId: ${weather.timezoneId}',
                    style: const TextStyle(fontSize: 22)),
                Text('Temperature: ${weather.temperature}',
                    style: const TextStyle(fontSize: 22)),
                Text('FeelsLike: ${weather.feelsLike}',
                    style: const TextStyle(fontSize: 22)),
                Text('WindSpeed: ${weather.windSpeed}',
                    style: const TextStyle(fontSize: 22)),
              ],
            );

          case WeatherStatusEnum.error:
            return Text(
              'Unable to load weather: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
