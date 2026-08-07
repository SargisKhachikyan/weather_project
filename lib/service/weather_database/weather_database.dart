import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDatabase {
  Database? _db;

  Future<Database> getDb() async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
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
