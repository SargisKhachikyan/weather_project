import 'package:flutter/material.dart';

class WeatherSummary extends StatelessWidget {
  const WeatherSummary({
    super.key,
    required this.temperature,
    required this.windSpeed,
    required this.feelsLike,
  });
  final int temperature;
  final int windSpeed;
  final int feelsLike;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '$temperature°',
            style: const TextStyle(
              fontSize: 116,
              fontWeight: FontWeight.w200,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'wind $windSpeed km/h',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          'Feels like $feelsLike°',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17, color: Color(0xFFE4EFF7)),
        ),
      ],
    );
  }
}
