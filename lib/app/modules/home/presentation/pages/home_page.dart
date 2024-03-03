import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:app_caixinha/app/core/routes/app_routes.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/home_controller.dart';
import '../widgets/empty_participants_start_widget.dart';
import '../widgets/text_field_editor_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Caixinha',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.colorPrimary,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              AppColors.colorPrimary,
              AppColors.colorSurface,
              AppColors.colorTertiary,
            ],
            stops: const [0.05, 0.8, 0.9],
          )),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            direction: Axis.vertical,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '2024',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.colorPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Valor (mensal): R\$ 50,00',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Pagar até: dia 10',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.colorSurface,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Participantes',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.colorPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: controller.participantes.isEmpty,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: EmptyParticipantsStartWidget(
                              onAddPressed: () => _showAddParticipantModal(context),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.participantes.isNotEmpty,
                        child: Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.participantes.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                      AppRoutes.detailsParticipant,
                                      arguments: {
                                        'participantId':
                                            controller.participantes[index].id
                                      },
                                    ).then((value) {
                                      if (value == 'deleted') {
                                        controller.loadAllParticipants();
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          controller.participantes[index].nome,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        Text(
                                          'meses: ${controller.participantes[index].pagamentos.length}',
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                        const SizedBox(width: 10),
                                        Icon(
                                          Icons.keyboard_double_arrow_right,
                                          color: AppColors.colorPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: controller.participantes.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => _showAddParticipantModal(context),
                icon: const Icon(Icons.person_add),
                label: const Text('Novo Participante'),
              )
            : null,
      ),
    );
  }

  void _showAddParticipantModal(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (_) {
          return AlertDialog(
            icon: const Icon(Icons.person, size: 48),
            title: const Text('Novo participante'),
            content: TextFieldEditorWidget(
              hint: 'Nome',
              validation: (value) {
                if (value.isEmpty) {
                  return 'Digite o nome do participante';
                }
                return null;
              },
              onConfirm: (name) {
                controller.addNewParticipant(name);
                GlobalMessage.show('Novo participante adicionado!',
                    icon: Icons.person);
                Modular.to.pop();
              },
            ),
          );
        });
  }
}
