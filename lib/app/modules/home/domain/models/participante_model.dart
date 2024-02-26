import 'caixinha_model.dart';
import 'pagamento_caixinha_model.dart';

class ParticipanteModel {
  int? id;
  String? nome;
  CaixinhaModel? caixinha;
  List<PagamentoCaixinhaModel> pagamentos = [];
}
