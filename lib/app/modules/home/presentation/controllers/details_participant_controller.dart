import 'dart:io';

import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:app_caixinha/app/modules/home/domain/models/month_enum_model.dart';
import 'package:app_caixinha/app/modules/home/domain/models/participante_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsParticipantController {
  ParticipanteModel? participant;
  // todo switch to late after repository implementation

  void loadParticipant(int participantId) {
    // todo load participant
  }

  String getParticipantName() {
    return participant?.nome ?? '';
  }

  void deleteParticipant() {
    // todo delete participant
    GlobalMessage.show('Participante removido!', milliseconds: 15000, closeIcon: true);
  }

  int totalMonths() {
    return participant?.pagamentos.length ?? 0;
  }

  getTotal() {
    double total = 0;
    participant?.pagamentos.forEach((element) {
      total += element.valor ?? 0;
    });

    return NumberFormat
        .currency(locale: Platform.localeName, symbol: 'R\$')
        .format(total);
  }

  getMonthValue(int monthIndex) {
    double value = participant?.pagamentos
            .firstWhere((element) => element.mes == MonthEnumModel.values[monthIndex])
            .valor ?? 0;

    return NumberFormat
        .currency(locale: Platform.localeName, symbol: 'R\$')
        .format(value);
  }

  bool isMonthPaid(int monthIndex) {
    return participant?.pagamentos
        .any((element) => element.mes == MonthEnumModel.values[monthIndex]) ?? false;
  }

  void checkMonth(int monthIndex) {
    // todo check month
    GlobalMessage.show('Ok, tudo certo!', milliseconds: 600, icon: Icons.attach_money);
  }

  void updateValue(String value, int monthIndex) {
    // todo update month value
    GlobalMessage.show('Valor alterado!', milliseconds: 600, icon: Icons.attach_money);
  }
}
