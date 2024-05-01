import 'dart:collection';

import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:signals/signals.dart';

import '../../data/repository/annual_savings_scheme_repository.dart';
import '../../data/repository/month_payment_repository.dart';
import '../../data/repository/participant_repository.dart';
import '../../domain/models/annual_savings_scheme.dart';
import '../../domain/models/participant.dart';

class HomeController {
  HomeController(this.annualSavingsSchemeRepository, this.participantRepository, this.monthPaymentRepository);

  final AnnualSavingsSchemeRepository annualSavingsSchemeRepository;
  final ParticipantRepository participantRepository;
  final MonthPaymentRepository monthPaymentRepository;

  final selectedScheme = signal<AnnualSavingsScheme?>(null);
  final schemes = listSignal<AnnualSavingsScheme>([]);
  final participants = listSignal<Participant>([]);

  final Map<int, int> paymentsCount = {};

  init() async {
    schemes.addAll(await annualSavingsSchemeRepository.findAll());
    selectScheme(schemes.firstOrNull);
  }

  loadAllParticipantsByScheme() async {
    if (selectedScheme.value != null) {
      paymentsCount.clear();
      paymentsCount.addAll(await monthPaymentRepository.countByParticipant());

      participants.set(
          await participantRepository.findByScheme(selectedScheme.value!.id!));
    }
  }

  addNewParticipant(String name) async {
    final newParticipant = Participant(
      name: name,
      annualSavingsSchemeId: selectedScheme.value?.id!,
    );
    await participantRepository.save(newParticipant);
    GlobalMessage.show('Novo participante adicionado!');
    loadAllParticipantsByScheme();
  }

  annualSavingsSchemeFormCallback(response) async {
    if (response != null) {
      final result = await annualSavingsSchemeRepository.findAll();

      final ids = schemes.map((e) => e.id);
      final inserted = result.where((element) => !ids.contains(element.id)).singleOrNull;

      final persistedScheme = inserted ?? result
            .where((element) => element.id == selectedScheme.value?.id)
            .singleOrNull;

      selectedScheme.set(persistedScheme ?? result.lastOrNull);
      schemes.set(result);
    }
  }

  participantDetailsPageCallback(response) {
    loadAllParticipantsByScheme();
  }

  selectScheme(AnnualSavingsScheme? scheme) {
    selectedScheme.set(scheme);
    loadAllParticipantsByScheme();
  }

  int getParticipantPaymentsCount(int participantId) {
    return paymentsCount[participantId] ?? 0;
  }
}