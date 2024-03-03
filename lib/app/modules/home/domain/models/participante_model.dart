import 'caixinha_model.dart';
import 'pagamento_caixinha_model.dart';

class ParticipanteModel {
  ParticipanteModel({required this.id, required this.nome, this.caixinha});

  int id;
  String nome;
  CaixinhaModel? caixinha;

  List<PagamentoCaixinhaModel> pagamentos = [];
}
