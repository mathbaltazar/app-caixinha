import 'package:app_caixinha/app/core/presentation/utils/text_utils.dart';
import 'package:app_caixinha/app/core/routes/app_routes.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals_flutter.dart';

import '../controllers/home_controller.dart';
import '../widgets/empty_participants_start_widget.dart';
import '../widgets/text_field_editor_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final controller = Modular.get<HomeController>();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    widget.controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: _buildNavigationDrawer(context),
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: const Text(
            'Caixinha',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Watch.builder(
              builder: (ctx) => Visibility(
                visible: widget.controller.selectedScheme.value != null,
                child: MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () => _openSavingsSchemeForm(schemeId: widget.controller.selectedScheme.value?.id),
                      child: const Text('Editar caixinha'),
                    )
                  ],
                  builder: (_, menuController, __) => IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      menuController.isOpen
                          ? menuController.close()
                          : menuController.open();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                 begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.colorPrimary.withAlpha(200),
                  AppColors.colorSurface,
                ],
                stops: const [0.05, 0.8],
              )),
          child: Watch((context) => widget.controller.schemes.isEmpty ? _buildStartScreenWidget() : _buildSavingsSchemeParticipants()),
        ),
        floatingActionButton: Watch((context) =>
            Visibility(
              visible: widget.controller.participants.isNotEmpty,
              child: FloatingActionButton.extended(
                onPressed: () => _showAddParticipantModal(context),
                icon: const Icon(Icons.person_add),
                label: const Text('Novo Participante'),
              ),
            ),
          )),
    );
  }

  Widget _buildStartScreenWidget() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.vertical,
      children: [
        Flexible(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money_rounded,
                  color: AppColors.colorPrimary,
                  size: 48,
                ),
                const Text(
                  'Olá! Bem vindo ao app Caixinha!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Vamos começar a gerenciar as finanças?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 100),
                FilledButton.tonalIcon(
                  onPressed: _openSavingsSchemeForm,
                  icon: const Icon(Icons.add_home_outlined),
                  label: const Text('NOVA CAIXINHA'),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }

  Widget _buildSavingsSchemeParticipants() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.vertical,
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.controller.selectedScheme.value?.year}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Valor (mensal): R\$ ${TextUtils.formatCurrency(widget.controller.selectedScheme.value?.amountPerMonth)}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              Text(
                'Vence dia ${widget.controller.selectedScheme.value?.dueDay}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Flexible(
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Participantes',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Watch((context) => widget.controller.participants.isEmpty
                      ? SingleChildScrollView(
                            child: EmptyParticipantsStartWidget(
                              onAddPressed: () => _showAddParticipantModal(context)
                            ),
                          )
                        : Scrollbar(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.controller.participants.length,
                              separatorBuilder: (_, __) => Divider(
                                color: AppColors.colorPrimary,
                                indent: 15,
                                thickness: 0.30,
                              ),
                              itemBuilder: (_, index) {
                                return ListTile(
                                  onTap: () => _openParticipantDetailsPage(widget.controller.participants[index].id!),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.controller.participants[index]
                                            .name!,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'meses: ${widget.controller.getParticipantPaymentsCount(widget.controller.participants[index].id!)}',
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                    color: AppColors.colorPrimary,
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
              onConfirm: (name) async {
                await widget.controller.addNewParticipant(name);
                Modular.to.pop();
              },
            ),
          );
        });
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Watch.builder(
      builder: (context) => NavigationDrawer(
        selectedIndex: widget.controller.schemes.indexWhere((element) => widget.controller.selectedScheme.value?.id == element.id),
        onDestinationSelected: (index) {
          if (index == widget.controller.schemes.length) {
            _openSavingsSchemeForm();
          } else {
            widget.controller.selectScheme(widget.controller.schemes[index]);
          }

          scaffoldKey.currentState!.closeDrawer();
        },
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('App Caixinha', style: TextStyle(fontWeight: FontWeight.w400),),
          ),
          ...widget.controller.schemes.map((element) => NavigationDrawerDestination(
                    icon: const Icon(Icons.attach_money),
                    selectedIcon: const Icon(Icons.check),
                    label: Text(element.description != null
                        ? '${element.year}  - ${element.description}'
                        : '${element.year}'),
                  )),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.add_home_outlined),
            label: Text('Nova Caixinha'),
          ),
        ],
      ),
    );
  }

  _openSavingsSchemeForm({int? schemeId}) async {
    final args = {'schemeId': schemeId};
    final response = await Modular.to.pushNamed(AppRoutes.savingsSchemeForm, arguments: args);
    debugPrint('Response from AnnualSavingsSchemeForm was: $response');
    widget.controller.annualSavingsSchemeFormCallback(response);
  }

  _openParticipantDetailsPage(int participantId) async {
    final args = {'participantId': participantId};
    final response = await Modular.to.pushNamed(AppRoutes.participantDetails, arguments: args);
    debugPrint('Response from ParticipantDetailsPage was: $response');
    widget.controller.participantDetailsPageCallback(response);
  }
}
