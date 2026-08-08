import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // добавлено
import 'package:weather_project/home_page/home_page.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart'; // добавлено
import 'package:weather_project/service/locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locator().registerDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (_) => weatherGetIt.get<WeatherBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}
