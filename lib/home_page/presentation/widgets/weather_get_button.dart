import 'package:flutter/material.dart';

class WeatherGetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WeatherGetButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Get weather'),
    );
  }
}