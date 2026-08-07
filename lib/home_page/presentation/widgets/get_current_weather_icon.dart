import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class GetCurrentWeatherIcon extends StatelessWidget {
  final double temperature;
  final double? size;
  final Color color;

  const GetCurrentWeatherIcon({
    super.key,
    required this.temperature,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (temperature >= 28) {
      return BoxedIcon(
        WeatherIcons.day_sunny,
        size: size,
        color: Colors.amber,
      );
    } else if (temperature >= 20) {
      return BoxedIcon(
        WeatherIcons.day_cloudy,
        size: size,
        color: Colors.grey,
      );
    } else if (temperature >= 10) {
      return BoxedIcon(
        WeatherIcons.day_rain_mix,
        size: size,
        color: Colors.indigo,
      );
    } else {
      return BoxedIcon(
        WeatherIcons.day_snow,
        size: size,
        color: Colors.blueAccent,
      );
    }
  }
}
