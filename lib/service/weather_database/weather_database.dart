import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDatabase {
  Database? _db;

  Future<bool> initDB() async {
    try {
      final path = join(await getDatabasesPath(), 'weather.db');
      _db = await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE weather_info (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city_name TEXT,
            wind_speed TEXT,
            flag_local_path TEXT,
            temperature DOUBLE
          )
        ''');
        },
      );
      print('DB path $path');

      return true;
    } catch (e) {
      print('Error initializing database: $e   (try catch)');
      return false;
    }
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'weather.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE weather_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            temperature REAL,
            flag TEXT
          )
        ''');
      },
    );
  }

  Future<Database> getDb() async {
    return _db ?? await _initDB();
  }

  Future<void> insertCountry({
    required String country,
    required double temperature,
    required String flag,
  }) async {
    final db = await getDb();

    await db.insert(
      'weather_data',
      {
        'country': country,
        'temperature': temperature,
        'flag': flag,
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
