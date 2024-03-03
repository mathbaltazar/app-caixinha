
import 'package:app_caixinha/app/modules/home/domain/models/participante_model.dart';

class HomeController {
  HomeController();

  final List<ParticipanteModel> participantes = [
    ParticipanteModel(id: 0, nome: 'Aloísio'),
    ParticipanteModel(id: 1, nome: 'Matheus'),
    ParticipanteModel(id: 2, nome: 'Maria'),
    ParticipanteModel(id: 3, nome: 'Santino'),
    ParticipanteModel(id: 4, nome: 'João'),
    ParticipanteModel(id: 5, nome: 'Dona Hermínia'),
  ];

  void loadAllParticipants() {
    // todo load all participants
  }

  void addNewParticipant(String name) {
    // todo salvar novo participante
  }


}