import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import '../../data/repository/annual_savings_scheme_repository.dart';
import '../../data/repository/month_payment_repository.dart';
import '../../data/repository/participant_repository.dart';
import '../../domain/models/month_enum_model.dart';
import '../../domain/models/month_payment.dart';
import '../../domain/models/participant.dart';

class DetailsParticipantController {
  DetailsParticipantController(this.participantRepository, this.annualSavingsSchemeRepository, this.monthPaymentRepository);

  final ParticipantRepository participantRepository;
  final AnnualSavingsSchemeRepository annualSavingsSchemeRepository;
  final MonthPaymentRepository monthPaymentRepository;

  final participant = signal<Participant?>(null);
  final paymentsList = listSignal<MonthPayment?>(List.filled(MonthEnumModel.values.length, null));
  final totalAmount = signal<double>(0);
  final monthsPaid = signal(0);
  final itemExpanded = signal(-1);

  init(int participantId) async {
    participant.set(await participantRepository.findById(participantId));
    loadParticipantPayments();
  }

  deleteParticipant() async {
    await participantRepository.deleteById(participant.value!.id!);
    GlobalMessage.show('Participante removido!', milliseconds: 15000, closeIcon: true);
  }

  checkMonth(int monthIndex) async {
    MonthPayment? payment = paymentsList[monthIndex];

    if (payment == null) {
      var annualSavingsSchemeId = participant.value!.annualSavingsSchemeId;
      double annualSavingsAmount = await annualSavingsSchemeRepository
          .getAmountById(annualSavingsSchemeId!);

      await monthPaymentRepository.save(
          MonthPayment(
            month: MonthEnumModel.values[monthIndex],
            amount: annualSavingsAmount,
            participantId: participant.value!.id!,)
      );
    } else {
      await monthPaymentRepository.deleteByMonthAndByParticipant(
        month: MonthEnumModel.values[monthIndex],
        participantId: participant.value!.id!,
      );
    }

    GlobalMessage.show('Ok, tudo certo!', milliseconds: 600, icon: Icons.attach_money);
    loadParticipantPayments();
  }

  updateMonthValue(double value, int monthIndex) async {
    MonthPayment? payment = paymentsList[monthIndex];
    if (payment != null) {
      payment.amount = value;
      await monthPaymentRepository.update(payment);

      GlobalMessage.show('Salvo!', milliseconds: 600, icon: Icons.attach_money);
      loadParticipantPayments();
    }
  }

  loadParticipantPayments() async {
    List<MonthPayment> result = await monthPaymentRepository
        .findAllByParticipant(participant.value!.id!);

    List<MonthPayment?> updatedList = [];
    for (int i = 0; i < paymentsList.length; i++) {
      MonthPayment? payment = result
          .where((element) => element.month == MonthEnumModel.values[i])
          .singleOrNull;
      updatedList.add(payment);
    }

    double total = updatedList.fold(
        0, (previousValue, element) => previousValue + (element?.amount ?? 0));

    monthsPaid.set(result.length);
    totalAmount.set(total);
    paymentsList.set(updatedList);
  }

  expandCollapseItem(int index) {
    itemExpanded.set(itemExpanded.value != index ? index : -1, force: true);
  }

}
