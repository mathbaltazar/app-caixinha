import 'month_enum_model.dart';

class MonthPayment {
  MonthPayment(
      {required this.month, required this.amount, required this.participantId});

  MonthEnumModel month;
  double amount;
  int participantId;

  Map<String, Object> toMap() {
    return {
      'month': month.name,
      'amount': amount,
      'participant_id': participantId,
    };
  }

  static MonthPayment fromMap(Map<String, dynamic> map) {
    return MonthPayment(
      month: MonthEnumModel.values.singleWhere((e) => e.name == map['month']),
      amount: map['amount'] as double,
      participantId: map['participant_id'] as int,
    );
  }
}
