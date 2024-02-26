import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:app_caixinha/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/text_field_editor_widget.dart';

class DetailsParticipantPage extends StatelessWidget {
  const DetailsParticipantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rosa'),
          actions: [
            IconButton(
                onPressed: () {
                  _deleteParticipant(context);
                },
                icon: const Icon(Icons.delete))
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
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '- Meses pagos: 8',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '- Total pago: R\$ 220,00',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: CheckboxListTile(
                        side: const BorderSide(width: 0.8),
                        controlAffinity: ListTileControlAffinity.leading,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.outlineColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(48)),
                        title: Text(
                          DateTime(2024, index + 1)
                              .monthLiteral()
                              .toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Valor pago: R\$ 50,00'),
                        value: true,
                        onChanged: (_) {},
                        secondary:
                            (true) // todo caso mês pago, liberar edição valor
                                ? IconButton(
                                    onPressed: () {
                                      _editPaymentValue(context, index + 1);
                                    },
                                    icon: Icon(
                                      Icons.attach_money,
                                      color: AppColors.colorPrimary,
                                      size: 20,
                                    ),
                                  )
                                : null,
                      ),
                    );
                  }),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void _editPaymentValue(BuildContext context, int month) {
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
              onConfirm: (name) {
                // validate
                // todo salvar novo valor
                Modular.to.pop();
              },
            ),
          );
        });
  }

  void _deleteParticipant(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.delete),
          title: const Text('Remover o participante?', style: TextStyle(fontSize: 18),),
          content: const Text('**Todos os dados da caixinha deste participante vão apagar juntos!**', style: TextStyle(fontSize: 14),),
          actions: [
            TextButton(
              onPressed: Modular.to.pop,
              child: const Text('Cancelar', style: TextStyle(fontSize: 16),),
            ),
            TextButton(
              onPressed: () {
                Modular.to.pop(true);
              },
              child: const Text('Remover', style: TextStyle(fontSize: 16),),
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
