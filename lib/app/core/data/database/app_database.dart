import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_configuration.dart';

class AppDatabase {
  static Future<Database> instance() async {
    return await openDatabase(
      join(await getDatabasesPath(), DatabaseConfiguration.databaseFilename),
      version: DatabaseConfiguration.version,
      onCreate: DatabaseConfiguration.onCreate,
      onConfigure: DatabaseConfiguration.onConfigure
    );
  }
}
