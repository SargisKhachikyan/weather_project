import 'package:flutter/material.dart';

class WeatherTextField extends StatelessWidget {
  final TextEditingController controller;
  const WeatherTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'City or Country',
        
      ),
    );
  }
}
