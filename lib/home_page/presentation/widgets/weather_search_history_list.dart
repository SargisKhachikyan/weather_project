import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
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
          leading: SizedBox(
            width: 32,
            height: 32,
            child: flag.isNotEmpty
                ? FutureBuilder<Directory>(
                    future: getApplicationDocumentsDirectory(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Icon(Icons.error_outline, size: 32);
                      }
                      final file = File('${snapshot.data!.path}/$flag');
                      if (!file.existsSync()) {
                        return const Icon(Icons.flag, size: 32);
                      }
                      return Image.file(file, fit: BoxFit.cover);
                    },
                  )
                : const Icon(
                    Icons.flag,
                    size: 32,
                  ),
          ),
          title: Text(country.isNotEmpty ? country : 'Unknown location'),
          subtitle: Text('$temperature° (Wind: $windSpeed)'),
        );
      },
    );
  }
}
