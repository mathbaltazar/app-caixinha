import 'dart:async';

import 'package:app_caixinha/app/core/data/database/database_tables.dart';
import 'package:app_caixinha/app/core/data/repository/repository.dart';
import 'package:app_caixinha/app/modules/home/domain/models/month_enum_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/month_payment.dart';

class MonthPaymentRepository extends Repository<MonthPayment> {
  @override
  Future<void> save(MonthPayment model) async {
    final db = await getDatabase();
    await db.insert(
      DatabaseTables.monthPayment,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<MonthPayment>> findAll() async {
    final db = await getDatabase();
    return (await db.query(DatabaseTables.monthPayment))
        .map(MonthPayment.fromMap)
        .toList();
  }

  @override
  Future<MonthPayment?> findById(int? id) async {
    return null;
  }

  @override
  Future<void> deleteById(int id) async {}

  Future<List<MonthPayment>> findAllByParticipant(int participantId) async {
    final db = await getDatabase();
    List<Map<String, Object?>> result = await db.query(
      DatabaseTables.monthPayment,
      where: 'participant_id = ?',
      whereArgs: [participantId],
    );

    return result.map(MonthPayment.fromMap).toList();
  }

  Future<void> deleteByMonthAndByParticipant(
      {required MonthEnumModel month, required int participantId}) async {
    final db = await getDatabase();
    db.delete(
      DatabaseTables.monthPayment,
      where: 'month = ? and participant_id = ?',
      whereArgs: [month.name, participantId],
    );
  }

  Future<Map<int, int>> countByParticipant() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
      'SELECT participant_id, COUNT(*) as count FROM ${DatabaseTables.monthPayment} GROUP BY participant_id',
    );

    return result.fold({}, (previousValue, element) {
      previousValue[element['participant_id']] = element['count'];
      return previousValue;
    }).cast<int, int>();
  }

  Future<void> update(MonthPayment payment) async {
    final db = await getDatabase();
    db.update(
      DatabaseTables.monthPayment,
      payment.toMap(),
      where: 'participant_id = ? and month = ?',
      whereArgs: [payment.participantId, payment.month.name]
    );
  }
}
