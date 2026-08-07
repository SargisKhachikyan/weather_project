import 'package:flutter/material.dart';

class WeatherGetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WeatherGetButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.sunny, size: 20),
      label: const Text('Get weather'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2F80ED),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
