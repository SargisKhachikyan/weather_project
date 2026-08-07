import 'package:flutter/material.dart';
import 'package:weather_project/home_page/presentation/widgets/get_current_weather_icon.dart';

class BigWeatherIcon extends StatelessWidget {
  final double temperature;
  const BigWeatherIcon({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetCurrentWeatherIcon(
          temperature: temperature,
          size: 72,
          color: const Color.fromARGB(255, 108, 107, 105),
        ),
        const SizedBox(height: 8),
        Text(
          '${temperature.toInt()}°C',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
