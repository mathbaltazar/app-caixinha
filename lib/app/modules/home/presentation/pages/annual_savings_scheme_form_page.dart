import 'package:app_caixinha/app/core/presentation/utils/textfield_input_mask.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals_flutter.dart';

import '../controllers/annual_savings_scheme_form_controller.dart';

class AnnualSavingsSchemeFormPage extends StatefulWidget {
  AnnualSavingsSchemeFormPage({super.key, this.schemeId});

  final int? schemeId;
  final controller = Modular.get<AnnualSavingsSchemeFormController>();

  @override
  State<AnnualSavingsSchemeFormPage> createState() => _AnnualSavingsSchemeFormPageState();
}

class _AnnualSavingsSchemeFormPageState extends State<AnnualSavingsSchemeFormPage> {

  @override
  void initState() {
    widget.controller.loadSchemeById(widget.schemeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Watch.builder(
              builder: (context) => Text(widget.controller.isEditing.value
                  ? 'Editar Caixinha'
                  : 'Criar Caixinha')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Ano',
                      style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Watch.builder(
                    builder: (_) => TextField(
                        controller: widget.controller.yearController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_today_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Ano',
                            counterText: '',
                            errorText: widget.controller.yearError.value
                        ),
                        maxLength: 4,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(height: 30),
                  Text('Descrição (opcional)',
                      style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextField(
                      controller: widget.controller.descriptionController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.edit_note),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Descrição',
                        counterText: '',
                      ),
                      maxLength: 255,
                      keyboardType: TextInputType.text),
                  const SizedBox(height: 30),
                  Text('Valor mensal',
                      style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Watch.builder(
                    builder: (_) => TextField(
                        controller: widget.controller.amountController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Valor Mensal',
                          errorText: widget.controller.amountError.value,
                        ),
                        inputFormatters: [TextfieldInputMask.currencyMask()],
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(height: 30),
                  Text('Vence dia',
                      style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Watch.builder(
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.controller.dueDayList
                          .map((day) => ChoiceChip(
                                label: Text(day.toString().padLeft(2, '0')),
                                checkmarkColor: AppColors.colorPrimary,
                                selected:
                                    widget.controller.selectedDay.value == day,
                                onSelected: (selected) => widget
                                    .controller.selectedDay
                                    .set(selected ? day : null),
                              )).toList(),
                    ),
                  ),
                  Watch.builder(
                      builder: (_) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                              widget.controller.dueDayError.value ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppColors.errorColor,
                                fontSize: 12,
                              ),
                            ),
                      )),
                  const SizedBox(height: 35),
                  FilledButton.tonalIcon(
                    onPressed: widget.controller.saveScheme,
                    icon: const Icon(Icons.add_home_outlined),
                    label: const Text('Salvar caixinha'),
                  ),
                  Watch.builder(
                    builder: (context) => Visibility(
                      visible: widget.controller.isEditing.value,
                      child: FilledButton.tonalIcon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                AppColors.errorColor.withOpacity(.9))),
                        onPressed: () => _showDeleteConfirmation(context),
                        icon:
                        const Icon(Icons.delete_outlined, color: Colors.white),
                        label: const Text(
                          'Excluir caixinha',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              icon: const Icon(Icons.delete),
              title: const Text('Confirma a exclusão'),
              content: const Text('Isso também irá excluir os seus participantes!'),
              actions: [
                TextButton(
                  onPressed: Modular.to.pop,
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    widget.controller.deleteCaixinha();
                    Modular.to.pop(); // for dialog
                    Modular.to.pop('deleted');
                  },
                  child: const Text('Excluir'),
                ),
              ],
            ));
  }
}
