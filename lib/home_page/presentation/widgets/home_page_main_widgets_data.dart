import 'package:flutter/material.dart';
import 'package:weather_project/home_page/presentation/widgets/get_current_weather_icon.dart';
import 'package:weather_project/home_page/presentation/widgets/weather_small_widget.dart';

class HomePageMainWidgetsData extends StatelessWidget {
  final String flag;
  final dynamic weather;
  final double temperature;

  const HomePageMainWidgetsData({
    super.key,
    required this.flag,
    required this.weather,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          flag,
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 10),
        Text(
          weather.name,
          style: const TextStyle(
            color: Color(0xFF12345A),
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          weather.country,
          style: const TextStyle(
            color: Color(0xFF506784),
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 18),
        GetCurrentWeatherIcon(
          temperature: temperature,
          size: 105,
          color: const Color(0xFFFFB020),
        ),
        const SizedBox(height: 14),
        Text(
          '${weather.temperature}°',
          style: const TextStyle(
            color: Color(0xFF12345A),
            fontSize: 78,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          'Feels like ${weather.feelsLike}°C',
          style: const TextStyle(
            color: Color(0xFF506784),
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: WeatherSmallBox(
                icon: Icons.air,
                title: 'Wind',
                value: '${weather.windSpeed} km/h',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WeatherSmallBox(
                icon: Icons.thermostat,
                title: 'Feels',
                value: '${weather.feelsLike}°',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: WeatherSmallBox(
                icon: Icons.location_on,
                title: 'Region',
                value: weather.region,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WeatherSmallBox(
                icon: Icons.public,
                title: 'Unit',
                value: weather.unit.toUpperCase(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
