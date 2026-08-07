import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final IconData icon;
  final double temperature;

  const CurrentWeatherWidget({
    super.key,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 80, color: Colors.orange),
        const SizedBox(height: 8),
        Text(
          '${temperature.round()}°',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
