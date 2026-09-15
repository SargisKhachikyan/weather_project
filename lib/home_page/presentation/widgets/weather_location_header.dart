import 'package:flutter/material.dart';

class WeatherLocationHeader extends StatelessWidget {
  const WeatherLocationHeader({
    super.key,
    required this.city,
    required this.country,
    required this.flagUrl,
  });
  final String city;
  final String country;
  final String flagUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 38),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(flagUrl, width: 26, height: 20, fit: BoxFit.contain),
            const SizedBox(width: 10),
            Flexible(
              child: Text(country, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ],
    );
  }
}
