import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDatabase {
  Database? _db;

  Future<bool> initDB() async {
    try {
      final path = join(await getDatabasesPath(), 'weather.db');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE weather_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            temperature REAL,
            flag TEXT,
            wind_speed TEXT
          )
        ''');
        },
      );
      print('DB path $path');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Database> getDb() async {
    if (_db != null) return _db!;
    await initDB();
    return _db!;
  }

  Future<void> insertCountry({
    required String country,
    required double temperature,
    required String flag,
    String? windSpeed,
  }) async {
    final db = await getDb();

    await db.insert(
      'weather_data',
      {
        'country': country,
        'temperature': temperature,
        'flag': flag,
        'wind_speed': windSpeed,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllCountries() async {
    final db = await getDb();
    return db.query('weather_data');
  }

  Future<void> clearAll() async {
    final db = await getDb();
    await db.delete('weather_data');
  }
}