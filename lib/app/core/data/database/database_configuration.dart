import 'package:app_caixinha/app/core/data/database/database_tables.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseConfiguration {
  static String get databaseFilename => 'app_caixinha.sqlite';

  static int get version => 1;

  static onCreate(Database db, int version) {
    db.execute('''
        CREATE TABLE IF NOT EXISTS ${DatabaseTables.annualSavingsScheme} (
          id INTEGER PRIMARY KEY,
          year INTEGER NOT NULL,
          amount_per_month REAL NOT NULL,
          due_day INTEGER NOT NULL,
          description TEXT
        )
    ''');

    db.execute('''
        CREATE TABLE IF NOT EXISTS ${DatabaseTables.participant} (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          annual_savings_scheme_id INTEGER
              REFERENCES annual_savings_scheme(id) ON DELETE CASCADE
        )
    ''');

    db.execute('''
        CREATE TABLE IF NOT EXISTS ${DatabaseTables.monthPayment} (
          month TEXT NOT NULL,
          amount REAL NOT NULL,
          participant_id INTEGER
              REFERENCES participant(id) ON DELETE CASCADE
        )
    ''');
  }

  static onConfigure(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
  }

}
