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

        final country = item['country'] as String? ?? '';
        final temperature = item['temperature'] as double? ?? 0.0;
        final flag = item['flag'] as String? ?? '';

        return ListTile(
          leading: Image.network(
            flag,
            width: 32,
          ),
          title: Text(country),
          subtitle: Text('$temperature°'),
        );
      },
    );
  }
}
