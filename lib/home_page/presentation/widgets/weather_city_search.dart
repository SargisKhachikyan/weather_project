import 'package:flutter/material.dart';

class WeatherCitySearch extends StatelessWidget {
  const WeatherCitySearch({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSearch,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: !isLoading,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => onSearch(),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search city',
        hintStyle: const TextStyle(color: Colors.white70),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
