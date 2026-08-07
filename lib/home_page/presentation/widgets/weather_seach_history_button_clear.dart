import 'package:flutter/material.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/state/weather_events.dart';

class WeatherSearchHistoryButtonClear extends StatelessWidget {
  const WeatherSearchHistoryButtonClear({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<WeatherBloc>().add(ClearAll());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2F80ED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Clear History',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
