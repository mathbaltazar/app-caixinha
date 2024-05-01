import 'package:app_caixinha/app/core/data/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository<T> {

  Database? _instance;
  Future<Database> getDatabase() async {
    return _instance ??= await AppDatabase.instance();
  }

  Future<void> save(T model);

  Future<List<T>> findAll();

  Future<T?> findById(int id);

  Future<void> deleteById(int id);
}
