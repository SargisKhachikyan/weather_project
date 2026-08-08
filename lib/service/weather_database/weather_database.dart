import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDatabase {
  Database? _db;
  static const String tableName = 'weather_info';

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

  Future<void> insertCountry({required Map<String, Object?> json}) async {
    await _db!.insert(
      tableName,
      json,
    );
  }

  Future<List<Map<String, dynamic>>> getAllCountries() async {
    return _db!.query(tableName);
  }

  Future<void> clearAll() async {
    await _db!.delete(tableName);
  }

  Future<void> getOnlyCountries() async {}

  Future<void> deleteDb() async {
    await _db!.delete(tableName);
  }
}
