import 'package:flutter/material.dart';

class WeatherHistoryTitle extends StatelessWidget {
  const WeatherHistoryTitle(
      {super.key,
      required this.hasHistory,
      required this.isLoading,
      required this.onClear});
  final bool hasHistory;
  final bool isLoading;
  final VoidCallback onClear;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Search history',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (hasHistory)
          TextButton(
            onPressed: isLoading ? null : onClear,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white38,
            ),
            child: const Text('Clear'),
          ),
      ],
    );
  }
}
