import 'hour_database.dart';

abstract class DatabaseManager {
  DatabaseManager._();

  static HourDatabase? _database;

  static Future<HourDatabase> getDatabase() async {
    if (_database == null) {
      // _database = await $FloorHourDatabase
      //     .databaseBuilder('hour_database.db')
      //     .build();
      ;
    }
    return _database!;
  }
}
