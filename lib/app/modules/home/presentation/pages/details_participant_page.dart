import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/models/month_enum_model.dart';
import '../controllers/details_participant_controller.dart';
import '../widgets/text_field_editor_widget.dart';

class DetailsParticipantPage extends StatefulWidget {
  DetailsParticipantPage({super.key, required this.participantId});

  final controller = Modular.get<DetailsParticipantController>();
  final int participantId;

  @override
  State<DetailsParticipantPage> createState() => _DetailsParticipantPageState();
}

class _DetailsParticipantPageState extends State<DetailsParticipantPage> {
  @override
  void initState() {
    widget.controller.loadParticipant(widget.participantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.controller.getParticipantName()),
          actions: [
            IconButton(
              onPressed: () => _showDeleteParticipantModal(context),
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Detalhes da caixinha:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.colorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '- Meses pagos: ${widget.controller.totalMonths()}',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '- Total pago: ${widget.controller.getTotal()}',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: MonthEnumModel.values.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: OutlinedButton(
                        onPressed: () => widget.controller.checkMonth(index),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.only(left: 10),
                        ),
                        child: ListTile(
                          title: Text(
                            MonthEnumModel.values[index].name.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                              'Valor pago: ${widget.controller.getMonthValue(index)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                iconSize: 20,
                                onPressed: widget.controller.isMonthPaid(index)
                                    ? () => _showEditPaymentValueModal(context, index)
                                    : null,
                              ),
                              Icon(
                                Icons.done_all,
                                size: 30,
                                color: widget.controller.isMonthPaid(index)
                                    ? AppColors.colorPrimary
                                    : Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPaymentValueModal(BuildContext context, int monthIndex) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (_) {
          return AlertDialog(
            icon: const Icon(Icons.attach_money, size: 48),
            title: const Text('Editar valor'),
            content: TextFieldEditorWidget(
              hint: 'Valor',
              currency: true,
              validation: (value) {
                double doubleValue =
                    double.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                return doubleValue == 0 ? 'Digite um valor' : null;
              },
              onConfirm: (value) {
                widget.controller.updateValue(value, monthIndex);
                Modular.to.pop();
              },
            ),
          );
        });
  }

  void _showDeleteParticipantModal(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.delete),
          title: const Text(
            'Remover o participante?',
            style: TextStyle(fontSize: 18),
          ),
          content: const Text('**Cuidado: Todos os dados da caixinha deste participante vão apagar juntos!**',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: Modular.to.pop,
              child: const Text('Cancelar', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                widget.controller.deleteParticipant();
                Modular.to.pop(true);
              },
              child: const Text('Remover', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        Modular.to.pop('deleted');
      }
    });
  }
}
