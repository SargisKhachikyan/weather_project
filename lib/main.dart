import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/firebase_options.dart';
import 'package:weather_project/home_page/home_page.dart';
import 'package:weather_project/home_page/state/weather_bloc.dart';
import 'package:weather_project/service/locator/locator.dart';
import 'package:weather_project/service/notifications/notifications_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationsService = NotificationsService();
  await notificationsService.init();
  await notificationsService.showTestNotification();

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
