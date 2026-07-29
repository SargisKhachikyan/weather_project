import 'package:flutter/material.dart';
import 'package:weather_project/home_page/home_page.dart';
import 'package:weather_project/service/locator/locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
