import 'dart:io';

import 'package:flutter/material.dart';

class WeatherHistoryList extends StatelessWidget {
  const WeatherHistoryList({
    super.key,
    required this.history,
    required this.directory,
  });
  final List<Map<String, dynamic>> history;
  final Future<Directory> directory;
  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Your recent searches will appear here.',
          style: TextStyle(color: Color(0xFFD9E8F4), height: 1.5),
        ),
      );
    }
    return FutureBuilder<Directory>(
      future: directory,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final item in history) _buildHistoryItem(item, snapshot.data),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item, Directory? folder) {
    final flag = item['flag']?.toString() ?? '';
    final temperature = num.tryParse(item['temperature']?.toString() ?? '');
    final country = item['country']?.toString() ?? 'Unknown location';
    final wind = item['wind_speed']?.toString() ?? '—';
    String temperatureText = '—';
    if (temperature != null) {
      temperatureText = '${temperature.round()}°';
    }

    Widget flagImage = const Icon(Icons.flag_outlined, size: 22);
    if (folder != null && flag.isNotEmpty) {
      flagImage = Image.file(
        File('${folder.path}/$flag'),
        fit: BoxFit.contain,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x30FFFFFF))),
      ),
      child: Row(
        children: [
          SizedBox(width: 28, height: 22, child: flagImage),
          const SizedBox(width: 12),
          Expanded(child: Text(country)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                temperatureText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'wind $wind',
                style: const TextStyle(fontSize: 12, color: Color(0xFFD9E8F4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
