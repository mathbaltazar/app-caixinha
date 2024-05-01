import 'package:app_caixinha/app/core/data/database/database_tables.dart';
import 'package:app_caixinha/app/core/data/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/participant.dart';

class ParticipantRepository extends Repository<Participant> {
  @override
  Future<void> save(Participant model) async {
    final db = await getDatabase();
    await db.insert(
      DatabaseTables.participant,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Participant>> findAll() async {
    final db = await getDatabase();
    return (await db.query(DatabaseTables.participant))
        .map(Participant.fromMap)
        .toList();
  }

  @override
  Future<Participant?> findById(int? id) async {
    final db = await getDatabase();
    List<Map<String, Object?>> result = await db.query(
      DatabaseTables.participant,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map(Participant.fromMap).firstOrNull;
  }

  @override
  Future<void> deleteById(int id) async {
    final db = await getDatabase();
    await db.delete(
      DatabaseTables.participant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Participant>> findByScheme(int schemeId) async {
    final db = await getDatabase();
    final result = (await db.query(
      DatabaseTables.participant,
      where: 'annual_savings_scheme_id = ?',
      whereArgs: [schemeId],
    ));

    return result.map(Participant.fromMap).toList();
  }
}
