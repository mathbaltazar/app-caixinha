class Participant {
  Participant({this.id, this.name, this.annualSavingsSchemeId});

  int? id;
  String? name;

  int? annualSavingsSchemeId;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'annual_savings_scheme_id': annualSavingsSchemeId,
    };
  }

  static Participant fromMap(Map<String, Object?> map) {
    return Participant(
      id: map['id'] as int,
      name: map['name'] as String,
      annualSavingsSchemeId: map['annual_savings_scheme_id'] as int,
    );
  }
}
