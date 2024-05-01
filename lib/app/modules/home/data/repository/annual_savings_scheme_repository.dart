import 'package:app_caixinha/app/core/data/database/database_tables.dart';
import 'package:app_caixinha/app/core/data/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/annual_savings_scheme.dart';

class AnnualSavingsSchemeRepository extends Repository<AnnualSavingsScheme> {
  @override
  Future<void> save(AnnualSavingsScheme model) async {
    final db = await getDatabase();
    await db.insert(
      DatabaseTables.annualSavingsScheme,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(AnnualSavingsScheme model) async {
    final db = await getDatabase();
    await db.update(
      DatabaseTables.annualSavingsScheme,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id]
    );
  }

  @override
  Future<List<AnnualSavingsScheme>> findAll() async {
    final db = await getDatabase();
    return (await db.query(DatabaseTables.annualSavingsScheme))
        .map(AnnualSavingsScheme.fromMap)
        .toList();
  }

  @override
  Future<AnnualSavingsScheme?> findById(int? id) async {
    final db = await getDatabase();
    List<Map<String, Object?>> result = await db.query(
      DatabaseTables.annualSavingsScheme,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map(AnnualSavingsScheme.fromMap).firstOrNull;
  }

  @override
  Future<void> deleteById(int id) async {
    final db = await getDatabase();
    await db.delete(
      DatabaseTables.annualSavingsScheme,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getAmountById(int annualSavingsSchemeId) async {
    final db = await getDatabase();
    final List<Map<String, Object?>> result = await db.query(
      DatabaseTables.annualSavingsScheme,
      columns: ['amount_per_month'],
      where: 'id = ?',
      whereArgs: [annualSavingsSchemeId],
    );

    return result.single['amount_per_month'] as double;
  }
}
