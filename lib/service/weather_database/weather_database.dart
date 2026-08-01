import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WeatherDatabase {
  final Future<Database> database = () async {
    final path = join(await getDatabasesPath(), 'weather.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE weather_data(id INTEGER PRIMARY KEY, city TEXT, country TEXT, temperature REAL, weather TEXT, flag TEXT)',
        );
      },
    );
  }();
}
