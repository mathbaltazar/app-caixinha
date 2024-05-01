class AnnualSavingsScheme {
  AnnualSavingsScheme({
    this.id,
    required this.year,
    required this.amountPerMonth,
    required this.dueDay,
    this.description,
  });

  int? id;
  int year;
  double amountPerMonth;
  int dueDay;
  String? description;

  static AnnualSavingsScheme fromMap(Map<String, Object?> map) {
    return AnnualSavingsScheme(
      id: map['id'] as int,
      year: map['year'] as int,
      amountPerMonth: map['amount_per_month'] as double,
      dueDay: map['due_day'] as int,
      description: map['description'] as String?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'year': year,
      'amount_per_month': amountPerMonth,
      'due_day': dueDay,
      'description': description,
    };
  }
}
