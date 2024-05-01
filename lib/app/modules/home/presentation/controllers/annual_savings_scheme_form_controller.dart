import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:app_caixinha/app/core/presentation/utils/text_utils.dart';
import 'package:app_caixinha/app/modules/home/data/repository/annual_savings_scheme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

import '../../domain/models/annual_savings_scheme.dart';

class AnnualSavingsSchemeFormController {
  AnnualSavingsSchemeFormController(this.repository);

  AnnualSavingsSchemeRepository repository;

  final yearController = TextEditingController();
  final yearError = signal<String?>(null);
  final descriptionController = TextEditingController();
  final amountController = TextEditingController(text: TextUtils.formatCurrency(0));
  final amountError = signal<String?>(null);

  final dueDayList = [5, 10, 15, 20, 25];
  final selectedDay = signal<int?>(null);
  final dueDayError = signal<String?>(null);

  int? _schemeId;

  final isEditing = signal(false);



  void loadSchemeById(int? schemeId) async {
    if (schemeId != null) {
      AnnualSavingsScheme? scheme = await repository.findById(schemeId);
      yearController.text = '${scheme!.year}';
      amountController.text = TextUtils.formatCurrency(scheme.amountPerMonth);
      selectedDay.set(scheme.dueDay);
      descriptionController.text = scheme.description ?? '';

      _schemeId = schemeId;
      isEditing.set(true);
    }
  }

  saveScheme() async {
    int? year = int.tryParse(yearController.text);
    double? amount = TextUtils.parseCurrency(amountController.text);
    int? dueDay = selectedDay.value;
    String description = descriptionController.text.trim();

    var validated = _validateForm(year, amount, dueDay);

    if (validated) {
      var scheme = AnnualSavingsScheme(
        year: year!,
        amountPerMonth: amount!,
        dueDay: dueDay!,
        description: description.isNotEmpty ? description : null,
      );

      if (_schemeId != null) {
        scheme.id = _schemeId;
        await repository.update(scheme);
      } else {
        await repository.save(scheme);
      }

      GlobalMessage.show(icon: Icons.check, 'Caixinha salva!');
      Modular.to.pop('persisted');
    }
  }

  deleteCaixinha() async {
    if (_schemeId != null) {
      await repository.deleteById(_schemeId!);
      GlobalMessage.show('Caixinha excluída!', milliseconds: 3500);
    }
  }

  bool _validateForm(int? year, double? amount, int? dueDay) {
    yearError.set(year == null
        ? '*Valor inválido'
        : year == 0
            ? '*Valor deve ser maior que zero'
            : null);
    amountError.set(amount == null
        ? '*Valor inválido'
        : amount == 0
            ? '*Valor deve ser maior que zero'
            : null);
    dueDayError
        .set(dueDay == null
        ? '*Selecione um dia para vencimento'
        : null);

    return [yearError, amountError, dueDayError]
        .every((error) => error.value == null);
  }

}