import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';

class WeatherSearchHistoryList extends StatefulWidget {
  const WeatherSearchHistoryList({super.key});

  @override
  State<WeatherSearchHistoryList> createState() =>
      _WeatherSearchHistoryListState();
}

class _WeatherSearchHistoryListState extends State<WeatherSearchHistoryList> {
  @override
  Widget build(BuildContext context) {
    final history = context.watch<WeatherBloc>().state.weatherHistory;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];

        final country = item['country']?.toString() ?? '';
        final temperature = item['temperature']?.toString() ?? 'unknown';
        final flag = item['flag']?.toString() ?? '';
        final windSpeed = item['wind_speed']?.toString() ?? 'unknown';

        return ListTile(
          leading: flag.isNotEmpty
              ? Image.file(
                  File(flag),
                  width: 32,
                )
              : const Icon(
                  Icons.flag,
                  size: 32,
                ),
          title: Text(country.isNotEmpty ? country : 'Unknown location'),
          subtitle: Text('$temperature° (Wind: $windSpeed)'),
        );

      },
    );
  }
}
