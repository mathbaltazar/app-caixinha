import 'package:app_caixinha/app/core/presentation/utils/text_utils.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals_flutter.dart';

import '../controllers/details_participant_controller.dart';
import '../widgets/month_list_item_widget.dart';
import '../widgets/text_field_editor_widget.dart';
import '../widgets/vertical_icon_text_widget.dart';

class ParticipantDetailsPage extends StatefulWidget {
  ParticipantDetailsPage({super.key, required this.participantId});

  final controller = Modular.get<DetailsParticipantController>();
  final int participantId;

  @override
  State<ParticipantDetailsPage> createState() => _ParticipantDetailsPageState();
}

class _ParticipantDetailsPageState extends State<ParticipantDetailsPage> {
  @override
  void initState() {
    widget.controller.init(widget.participantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Watch((_) => Text(widget.controller.participant.value?.name ?? '')),
          actions: [
            IconButton(
              onPressed: () => _showDeleteParticipantModal(context),
              icon: const Icon(Icons.delete),
            ),
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
                child: Watch((_) => Text(
                      'Meses pagos: ${widget.controller.monthsPaid}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Watch.builder(
                  builder: (_) => Text(
                    'Total pago: R\$ ${TextUtils.formatCurrency(widget.controller.totalAmount.value)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Watch((context) => Card(
                    margin: const EdgeInsets.all(15),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => Divider(
                          height: 2,
                          thickness: 0.7,
                          color: AppColors.colorPrimary.withOpacity(0.35)),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.controller.paymentsList.length,
                      itemBuilder: (_, index) => MonthListItemWidget(
                        monthIndex: index,
                        monthPaymentModel: widget.controller.paymentsList[index],
                        actions: <Widget>[
                          VerticalIconTextWidget(
                            icon: const Icon(Icons.edit),
                            iconSize: 20,
                            tonal: true,
                            label: const Text(
                              'Editar Valor',
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            onTap: widget.controller.paymentsList[index] != null
                                ? () =>
                                    _showEditPaymentValueModal(context, index)
                                : null,
                          ),
                          VerticalIconTextWidget(
                              icon: Icon(
                                  widget.controller.paymentsList[index] != null ?
                                  Icons.clear : Icons.attach_money_rounded),
                              iconSize: 20,
                              label: Text(
                                widget.controller.paymentsList[index] != null ?
                                'Remover Pagamento' : 'Marcar como pago',
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                              onTap: () => widget.controller.checkMonth(index)),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  _showEditPaymentValueModal(BuildContext context, int monthIndex) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (_) {
          return AlertDialog(
            icon: const Icon(Icons.attach_money, size: 48),
            title: const Text('Editar valor do mês'),
            content: TextFieldEditorWidget(
              hint: 'Valor',
              currency: true,
              validation: (value) {
                double doubleValue =
                    double.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                return doubleValue == 0 ? 'Digite um valor' : null;
              },
              onConfirm: (value) {
                widget.controller.updateMonthValue(TextUtils.parseCurrency(value)!, monthIndex);
                Modular.to.pop();
              },
            ),
          );
        });
  }

  _showDeleteParticipantModal(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.delete),
          title: const Text(
            'Remover o participante?',
            style: TextStyle(fontSize: 18),
          ),
          content: const Text('Todos os dados deste participante também serão apagados!',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: Modular.to.pop,
              child: const Text('Cancelar', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () async {
                await widget.controller.deleteParticipant();
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
