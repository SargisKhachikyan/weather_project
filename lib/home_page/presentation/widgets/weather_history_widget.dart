import 'package:flutter/material.dart';

class WeatherHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const WeatherHistoryWidget({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Search history",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];

            return Card(
              child: ListTile(
                leading: Image.network(
                  item['flag'],
                  width: 40,
                ),
                title: Text(item['country']),
                subtitle: Text(
                  "${item['temperature']}°C",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
