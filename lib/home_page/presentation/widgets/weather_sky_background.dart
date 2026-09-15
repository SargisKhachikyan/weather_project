import 'package:flutter/material.dart';

enum WeatherBackground {
  sunny('assets/weather/sunny.jpg', Alignment(0.65, 0)),
  clouds('assets/weather/clouds.jpg', Alignment.center),
  rainy('assets/weather/rainy.jpg', Alignment.center),
  snow('assets/weather/snow.jpg', Alignment.center),
  night('assets/weather/night.jpg', Alignment.center);

  const WeatherBackground(this.assetPath, this.alignment);

  // Temperature is supplied in Celsius.
  static WeatherBackground fromTemperature(int? temperature) {
    if (temperature == null) {
      return WeatherBackground.sunny;
    }
    if (temperature >= 20) {
      return WeatherBackground.sunny;
    } else if (temperature > 0) {
      return WeatherBackground.clouds;
    } else {
      return WeatherBackground.snow;
    }
  }

  final String assetPath;
  final Alignment alignment;
}

class WeatherSkyBackground extends StatelessWidget {
  const WeatherSkyBackground({
    super.key,
    this.background = WeatherBackground.sunny,
  });

  final WeatherBackground background;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          background.assetPath,
          fit: BoxFit.cover,
          alignment: background.alignment,
        ),
        Container(color: const Color.fromARGB(137, 43, 43, 43)),
      ],
    );
  }
}
