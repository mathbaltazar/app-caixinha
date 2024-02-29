import 'dart:math';

import 'package:app_caixinha/app/core/presentation/global_message.dart';
import 'package:app_caixinha/app/core/routes/app_routes.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/text_field_editor_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> participantes = [
    'Aloísio',
    'Matheus',
    'Roberto',
    'Maria',
    'Santino',
    'Aloísio',
    'Matheus',
    'Roberto',
    'Maria',
    'Santino',
    'Aloísio',
    'Matheus',
    'Roberto',
    'Maria',
    'Santino',
    'Aloísio',
    'Matheus',
    'Roberto',
    'Maria',
    'Santino',
    'Aloísio',
    'Matheus',
    'Roberto',
    'Maria',
    'Santino',
  ];

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
          decoration: BoxDecoration(color: AppColors.colorPrimary),
          height: MediaQuery.of(context).size.height,
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
                    Text(
                      '2024',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColors.colorPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Valor (mensal): R\$ 50,00',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Text(
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: participantes.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Modular.to.pushNamed(
                                    AppRoutes.detailsParticipant,
                                    arguments: {
                                      'participant': participantes[index]
                                    },
                                  ).then((value) {
                                    if (value == 'deleted') {
                                      // todo delete participant
                                    }
                                  });
                                },
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        participantes[index],
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Text(
                                        'meses pagos: ${Random().nextInt(13)}',
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddParticipantModal(context),
          icon: const Icon(Icons.person_add),
          label: const Text('Novo Participante'),
        ),
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
              onConfirm: (name) {
                // validate
                if (name.isEmpty) {
                  GlobalMessage.show('Digite o nome do participante');
                  return;
                }
                // todo salvar novo participante
                Modular.to.pop();
              },
            ),
          );
        });
  }
}
